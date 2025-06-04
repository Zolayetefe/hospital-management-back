const bcrypt = require('bcryptjs');
const { PrismaClient, Prisma } = require('../generated/prisma');
const prisma = new PrismaClient();

exports.getStaff = async () => {
  const staff = await prisma.user.findMany({
    where: {
      role: {
        in: ['doctor', 'nurse', 'lab_technician', 'finance', 'pharmacist', 'receptionist']
      }
    },
    include: {
      doctor: {
        include: {
          availabilities: {
            orderBy: [
              { day: 'asc' }
            ]
          }
        }
      },
      nurse: true
    }
  });

  return {
    staff: staff.map(staff => ({
      id: staff.id,
      name: staff.name,
      email: staff.email,
      role: staff.role,
      phone: staff.phone,
      status: staff.status,
      doctor: staff.doctor ? {
        ...staff.doctor,
        availabilities: staff.doctor.availabilities.map(availability => ({
          id: availability.id,
          day: availability.day,
          startTime: availability.startTime,
          endTime: availability.endTime
        }))
      } : null,
      nurse: staff.nurse
    }))
  };
};

exports.deleteStaff = async (id) => {

  try {
    const staff = await prisma.user.delete({ where: { id } });
    return { message: 'Staff deleted successfully' };
  } catch (error) {
    console.error('Error deleting staff:', error);
    throw new Error('Error deleting staff');
  }
};

exports.getDoctorSlots = async (doctorId) => {
  try {
    const slots = await prisma.doctorSlot.findMany({
      where: {
        doctorId
      },
      orderBy: [
        { day: 'asc' },
        { slotTime: 'asc' }
      ]
    });

    // Group slots by day
    const groupedSlots = slots.reduce((acc, slot) => {
      if (!acc[slot.day]) {
        acc[slot.day] = [];
      }
      acc[slot.day].push({
        id: slot.id,
        time: slot.slotTime,
        isBooked: slot.isBooked
      });
      return acc;
    }, {});

    return {
      doctorId,
      schedule: Object.entries(groupedSlots).map(([day, slots]) => ({
        day,
        slots
      }))
    };
  } catch (error) {
    console.error('Error fetching doctor slots:', error);
    throw new Error('Failed to fetch doctor slots');
  }
};

exports.getPatients = async () => {
  const patients = await prisma.user.findMany({
    where: { role: 'patient' }
  });
  return patients;
};
exports.toggleStaffStatus = async (userId) => {
  const user = await prisma.user.findUnique({
    where: { id: userId },
    select: { status: true }, // only fetch the status field
  });

  if (!user) {
    throw new Error('User not found');
  }

  const newStatus = user.status === 'active' ? 'suspend' : 'active';

  const updatedUser = await prisma.user.update({
    where: { id: userId },
    data: { status: newStatus },
  });

  return updatedUser;
};

exports.getTPatient = async () => {
  const patients = await prisma.user.count({
    where: { role: 'patient' }
  });
  return {
    totalPatients: patients
  };
};


exports.todayAppointment = async () => {
  const startOfDay = new Date();
  startOfDay.setUTCHours(0, 0, 0, 0);

  const endOfDay = new Date();
  endOfDay.setUTCHours(23, 59, 59, 999);

  const appointments = await prisma.appointment.count({
    where: {
      dateTime: {
        gte: startOfDay,
        lte: endOfDay
      }
    }
  });

  return {
    totalAppointments: appointments
  };
};

exports.getTotalActiveStaff = async () => {
  const totalActiveStaff = await prisma.user.count({
    where: {
      status: 'active',
      role: {
        in: [
          "doctor",
          "nurse",
          "lab_technician",
          "pharmacist",
          "finance",
          "receptionist",
          "admin"
        ]
      }
    }
  });

  return {
    totalActiveStaff
  };
};

exports.getMonthlyRevenue = async () => {
  const monthlyAppointmentRevenue = await prisma.appointmentFinance.aggregate({
    _sum: {
      amount: true
    }
  });

  const monthlyMedicineRevenue = await prisma.medicationBill.aggregate({
    _sum: {
      totalAmount: true
    }
  });

  const monthlyLabRevenue = await prisma.labTestBill.aggregate({
    _sum: {
      totalAmount: true
    }
  });

  const totalAppointment = monthlyAppointmentRevenue._sum.amount || 0;
  const totalMedicine = monthlyMedicineRevenue._sum.totalAmount || 0;
  const totalLab = monthlyLabRevenue._sum.totalAmount || 0;

  const monthlyTotalRevenue = totalAppointment + totalMedicine + totalLab;

  return { monthlyTotalRevenue };
};




