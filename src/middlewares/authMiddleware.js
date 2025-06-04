const jwt = require('jsonwebtoken');
const { PrismaClient } = require('../generated/prisma');
const prisma = new PrismaClient();

// Middleware to check if the user is authenticated
const isAuthenticated = async (req, res, next) => {
  const authHeader = req.headers['authorization'];
  // console.log("req from middleware",req.headers)

  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).json({ message: 'Authorization header missing or malformed' });
  }

  const token = authHeader.split(' ')[1];

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded;
    next();
  } catch (err) {
    return res.status(401).json({ message: 'Invalid or expired token' });
  }
};

module.exports = isAuthenticated;




// Middleware to check if the user is an admin
const isAdmin = async (req, res, next) => {
  const user = await prisma.user.findUnique({ where: { id: req.user.id } });

  if (user.role !== 'admin') {
    return res.status(403).json({ message: 'Access denied. Admins only.' });
  }

  next();
};



// Middleware to check if the user is a receptionist
const isReceptionist = async (req, res, next) => {
  const user = await prisma.user.findUnique({ where: { id: req.user.id } });
  if (user.role !== 'receptionist') {
    return res.status(403).json({ message: 'Access denied. Receptionists only.' });
  }
  next();
};



// Middleware to check if user is finance staff
const isFinanceStaff = (req, res, next) => {
  if (req.user && req.user.role === 'finance') {
      next();
  } else {
      res.status(403).json({
          success: false,
          message: 'Access denied. Finance staff only.'
      });
  }
};


// Middleware to check if user is nurse or finance staff
const isNurseOrFinanceStaff = async (req, res, next) => {
  if (req.user && (req.user.role === 'nurse' || req.user.role === 'finance')) {
    next();
  } else {
    res.status(403).json({
      success: false,
      message: 'Access denied. Nurse or finance staff only.'
    });
  }
}
const isNurse = async (req, res, next) => {
  if (req.user && req.user.role === 'nurse') {
    next();
  } else {
    res.status(403).json({ message: 'Access denied. Nurses only.' });
  }
}

const isPharmacist = async (req, res, next) => {    
  if (req.user && req.user.role === 'pharmacist') {
    next();
  } else {
    res.status(403).json({ message: 'Access denied. Pharmacists only.' });
  }
}
const expireDoctorSlots = async () => {
  try {
    const currentDateTime = new Date();

    // Find all past appointments that aren't already marked as expired or completed
    const pastAppointments = await prisma.appointment.findMany({
      where: {
        dateTime: {
          lt: currentDateTime
        },
        status: {
          in: ['pending', 'confirmed'] // Only update appointments that aren't already handled
        }
      },
      include: {
        doctor: true,
        patient: true
      }
    });

    console.log(`Found ${pastAppointments.length} past appointments to process`);

    for (const appointment of pastAppointments) {
      // Find the associated slot
      const slot = await prisma.doctorSlot.findFirst({
        where: {
          doctorId: appointment.doctorId,
          slotTime: appointment.dateTime.toTimeString().slice(0, 5),
          day: ['SUNDAY', 'MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY'][appointment.dateTime.getDay()]
        }
      });

      // Update the slot if found and still marked as booked
      if (slot && slot.isBooked) {
        await prisma.doctorSlot.update({
          where: { id: slot.id },
          data: { isBooked: false }
        });
        console.log(`Reset slot ${slot.id} for doctor ${appointment.doctorId}`);
      }

      // Update the appointment status
      await prisma.appointment.update({
        where: { id: appointment.id },
        data: { 
          status: 'expired',
          // You might want to add additional fields like
          // updatedAt: new Date(),
          // notes: 'Automatically marked as expired by system'
        }
      });
      console.log(`Marked appointment ${appointment.id} as expired`);
    }

    // Additionally, find and reset any booked slots in the past that might not have appointments
    const allBookedSlots = await prisma.doctorSlot.findMany({
      where: {
        isBooked: true
      }
    });

    for (const slot of allBookedSlots) {
      // Calculate the slot's actual date
      const slotDate = new Date();
      const currentDay = slotDate.getDay();
      const slotDayIndex = ['SUNDAY', 'MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY'].indexOf(slot.day);
      const daysToAdd = slotDayIndex - currentDay;
      slotDate.setDate(slotDate.getDate() + (daysToAdd >= 0 ? daysToAdd : daysToAdd + 7));

      // Set the slot's time
      const [hours, minutes] = slot.slotTime.split(':');
      slotDate.setHours(parseInt(hours, 10), parseInt(minutes, 10), 0, 0);

      // If the slot time is in the past, reset it
      if (slotDate < currentDateTime) {
        await prisma.doctorSlot.update({
          where: { id: slot.id },
          data: { isBooked: false }
        });
        console.log(`Reset past slot ${slot.id} without appointment`);
      }
    }

    console.log("Completed processing expired slots and appointments");
  } catch (error) {
    console.error('Error in scheduled task:', error);
    throw error; // Rethrow to handle it in the scheduler
  }
};


module.exports = { isAuthenticated, isAdmin, isReceptionist, isFinanceStaff, isNurseOrFinanceStaff, isNurse, isPharmacist, expireDoctorSlots};
