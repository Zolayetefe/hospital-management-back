const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { PrismaClient, Prisma } = require('../generated/prisma');
const prisma = new PrismaClient();

exports.login = async ({ email, password }) => {
  const user = await prisma.user.findUnique({ 
    where: { email },
    // include: {
    //   patient: true,
    //   doctor: true,
    //   nurse: true,
    //   labTechnician: true,
    //   pharmacist: true,
    //   financeStaff: true,
    //   receptionist: true
    // }
  });
  if (!user) {
    throw new Error('User not found');
  }
  if(user.status === 'suspend'){
    throw new Error('User is inactive');
  }

  const isMatch = await bcrypt.compare(password, user.password);
  if (!isMatch) {
    throw new Error('Invalid credentials');
  }

  const token = jwt.sign(
    { id: user.id, role: user.role, name: user.name, email: user.email },
    process.env.JWT_SECRET,
    { expiresIn: '1d' }
  );

  // Return what controller needs
  return {

    user: {
      id: user.id,
      name: user.name,   
      email: user.email,
      phone: user.phone,
      role: user.role,
      status: user.status,
      patient: user.patient,
      doctor: user.doctor,
      nurse: user.nurse,
      labTechnician: user.labTechnician,
      pharmacist: user.pharmacist,
      financeStaff: user.financeStaff,
      receptionist: user.receptionist,
    },
    token: token,
    message: 'Login successful',
  };
};


exports.getme = async (id) => {
  const user = await prisma.user.findUnique({ 
    where: { id },
    include: {
      patient: true,
      doctor: true,
      nurse: true
    }
  });
  return {
    user: {
      id: user.id,
      name: user.name,   
      email: user.email,
      role: user.role,
      patient: user.patient,
      doctor: user.doctor,
      nurse: user.nurse
    }
  };
};


exports.registerPatient = async (data) => {
  try {
    // Validate required fields
    const { name, email, password, phone, department, dateOfBirth, gender, address, emergencyContact } = data;
    // console.log("from service", data)

    if (!name || !email || !password || !phone || !dateOfBirth || !gender || !address || !emergencyContact) {
      throw new Error('All fields are required: name, email, password, phone, dateOfBirth, gender, address, emergencyContact');
    }

    // Check if user with email already exists
    const existingUser = await prisma.user.findUnique({
      where: { email },
    }).catch(error => {
      console.error('Error checking existing user:', error);
      if (error instanceof Prisma.PrismaClientKnownRequestError) {
        throw new Error(`Database error: ${error.message}`);
      }
      throw new Error('Database error while checking existing user');
    });

    if (existingUser) {
      throw new Error('User with this email already exists');
    }

    const hashedPassword = await bcrypt.hash(password, 10).catch(error => {
      console.error('Error hashing password:', error);
      throw new Error('Error processing password');
    });
// console.log("before creating patient")
    const user = await prisma.user.create({
      data: { 
        name,
        email,
        password: hashedPassword,
        role: 'patient',
        phone,
        patient: {
          create: {
            dateOfBirth: new Date(dateOfBirth),
            gender,
            address,
            emergencyContact
          }
        }
      },
      include: {
        patient: true
      }
    }).catch(error => {
      console.error('Error creating user:', error);
      
      // Handle specific Prisma errors
      if (error instanceof Prisma.PrismaClientKnownRequestError) {
        // P2002 is for unique constraint violations
        if (error.code === 'P2002') {
          throw new Error(`A user with this ${error.meta?.target} already exists`);
        }
        // P2000 is for invalid input data
        if (error.code === 'P2000') {
          throw new Error(`Invalid input data: ${error.message}`);
        }
      }
      
      if (error instanceof Prisma.PrismaClientValidationError) {
        throw new Error(`Validation error: ${error.message}`);
      }
      
      throw new Error(`Failed to create user: ${error.message}`);
    });

// set cookie
    // res.cookie('token', token, {
    //   httpOnly: true,
    //   secure: process.env.NODE_ENV === 'production',
    //   maxAge: 1 * 24 * 60 * 60 * 1000 // 1 day
    // });
   

    return { 
      message: 'Patient registered successfully', 
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
        patient: user.patient
      },
      // token 
    };
  } catch (error) {
    console.error('Registration error:', error);
    throw error;
  }
};


exports.registerStaff = async (data) => {
  try {
    // Validate required fields
    const { 
      name, 
      email, 
      password, 
      role, 
      phone, 
      specialization, 
      availabilities 
    } = data;
    
    console.log("Registration data:", data);

    if (!name || !email || !password || !role || !phone ) {
      throw new Error('All fields are required: name, email, password, role, phone');
    }

    // Role-specific validation
    switch (role) {
      case 'doctor':
        if (!specialization) {
          throw new Error('Specialization is required for doctors');
        }
        if (!availabilities || !Array.isArray(availabilities) || availabilities.length === 0) {
          throw new Error('At least one availability slot is required for doctors');
        }
        
        // Validate each availability slot
        availabilities.forEach((slot, index) => {
          if (!slot.day || !slot.startTime || !slot.endTime) {
            throw new Error(`Invalid availability slot at index ${index}. Each slot must have day, startTime, and endTime`);
          }
          
          // Validate day is a valid weekday
          const normalizedDay = slot.day.toUpperCase();
          if (!VALID_WEEKDAYS.includes(normalizedDay)) {
            throw new Error(`Invalid day "${slot.day}" at index ${index}. Day must be one of: ${VALID_WEEKDAYS.join(', ')}`);
          }
          
          slot.day = normalizedDay;

          // Validate time format (HH:mm)
          const timeRegex = /^([01]\d|2[0-3]):([0-5]\d)$/;
          if (!timeRegex.test(slot.startTime)) {
            throw new Error(`Invalid startTime "${slot.startTime}" at index ${index}. Time must be in 24-hour format (HH:mm)`);
          }
          if (!timeRegex.test(slot.endTime)) {
            throw new Error(`Invalid endTime "${slot.endTime}" at index ${index}. Time must be in 24-hour format (HH:mm)`);
          }

          // Validate endTime is after startTime
          const [startHour, startMinute] = slot.startTime.split(':').map(Number);
          const [endHour, endMinute] = slot.endTime.split(':').map(Number);
          const startMinutes = startHour * 60 + startMinute;
          const endMinutes = endHour * 60 + endMinute;
          
          if (endMinutes <= startMinutes) {
            throw new Error(`Invalid time range at index ${index}. endTime must be after startTime`);
          }
        });

        // Group availabilities by day and validate no overlapping times
        const availabilitiesByDay = availabilities.reduce((acc, slot) => {
          if (!acc[slot.day]) {
            acc[slot.day] = [];
          }
          acc[slot.day].push(slot);
          return acc;
        }, {});

        // Validate no overlapping times for each day
        Object.values(availabilitiesByDay).forEach(daySlots => {
          validateTimeSlotsForDay(daySlots);
        });
        break;

      case 'patient':
        throw new Error('Please use the patient registration endpoint for registering patients');
        break;

      case 'nurse':
      case 'lab_technician':
      case 'pharmacist':
      case 'finance':
      case 'receptionist':
      case 'admin':
        // These roles only need the basic fields which are already validated
        break;

      default:
        throw new Error(`Invalid role: ${role}`);
    }

    // Check if user with email already exists
    const existingUser = await prisma.user.findUnique({
      where: { email }
    });

    if (existingUser) {
      throw new Error('User with this email already exists');
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    // Create user with role-specific data
    const userData = {
      name,
      email,
      password: hashedPassword,
      role,
      phone,
    };

    // Create the user first
    const user = await prisma.user.create({
      data: userData
    });

    // Then create role-specific data
    let roleSpecificData = null;

    if (role !== 'admin') {  // Admin doesn't need additional data
      switch (role) {
        case 'doctor': {
          const doctor = await prisma.doctor.create({
            data: {
              userId: user.id,
              specialization,
            }
          });

          // Create availabilities
          await prisma.doctorAvailability.createMany({
            data: availabilities.map(avail => ({
              doctorId: doctor.id,
              day: avail.day,
              startTime: avail.startTime,
              endTime: avail.endTime
            }))
          });

          // Create slots for each availability period
          for (const availability of availabilities) {
            const slots = generateTimeSlots(
              doctor.id,
              availability.day,
              availability.startTime,
              availability.endTime
            );
            await prisma.doctorSlot.createMany({
              data: slots
            });
          }

          roleSpecificData = await prisma.doctor.findUnique({
            where: { id: doctor.id },
            include: {
              availabilities: true,
              slots: true
            }
          });
          break;
        }

        case 'nurse':
          roleSpecificData = await prisma.nurse.create({
            data: { userId: user.id }
          });
          break;

        case 'lab_technician':
          roleSpecificData = await prisma.labTechnician.create({
            data: { userId: user.id }
          });
          break;

        case 'pharmacist':
          roleSpecificData = await prisma.pharmacist.create({
            data: { userId: user.id }
          });
          break;

        case 'finance':
          roleSpecificData = await prisma.financeStaff.create({
            data: { userId: user.id }
          });
          break;

        case 'receptionist':
          roleSpecificData = await prisma.receptionist.create({
            data: { userId: user.id }
          });
          break;
      }
    }

    console.log(`Successfully registered ${role}:`, user.id);

    // Return appropriate response based on role
    return {
      message: `${role.charAt(0).toUpperCase() + role.slice(1)} registered successfully`,
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
        phone: user.phone,
        ...(roleSpecificData && { [role]: roleSpecificData })
      }
    };

  } catch (error) {
    console.error('Registration error:', error);
    throw error;
  }
};

exports.changePassword = async ({ userId, oldPassword, newPassword }) => {
  const user = await prisma.user.findUnique({
    where: { id: userId },
  });

  if (!user) {
    throw new Error('User not found');
  }

  const isMatch = await bcrypt.compare(oldPassword, user.password);
  if (!isMatch) {
    throw new Error('Incorrect old password');
  }

  const hashedNewPassword = await bcrypt.hash(newPassword, 10);

  await prisma.user.update({
    where: { id: userId },
    data: { password: hashedNewPassword },
  });

  return { message: 'Password changed successfully' };
};

exports.updateProfile = async (id, data) => {
  if ('email' in data || 'password' in data) {
    throw new Error('Updating email or password is not allowed in this route');
  }

  // Fetch user to determine role
  const existingUser = await prisma.user.findUnique({
    where: { id },
    include: { patient: true },
  });

  if (!existingUser) {
    throw new Error('User not found');
  }

  // Base update data
  const updateData = {
    name: data.name,
    phone: data.phone,
  };

  // If patient, add patient-specific updates
  if (existingUser.role === 'patient') {
    updateData.patient = {
      update: {
        ...(data.dateOfBirth && { dateOfBirth: new Date(data.dateOfBirth) }),
        ...(data.gender && { gender: data.gender }),
        ...(data.address && { address: data.address }),
        ...(data.emergencyContact && { emergencyContact: data.emergencyContact }),
      },
    };
  }

  const updatedUser = await prisma.user.update({
    where: { id },
    data: updateData,
    include: {
      patient: true,
    },
  });

  return {
    message: 'Profile updated successfully',
    user: {
      id: updatedUser.id,
      name: updatedUser.name,
      email: updatedUser.email,
      role: updatedUser.role,
      phone: updatedUser.phone,
      patient: updatedUser.patient,
    },
  };
};