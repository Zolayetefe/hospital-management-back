const adminService = require('../services/adminServices');

const { toggleStaffStatus } = require('../services/adminServices');

exports.toggleStaffStatusController = async (req, res) => {
  try {
    const { userId } = req.params;
    console.log(userId)
    const updatedUser = await toggleStaffStatus(userId);
    res.status(200).json({
      message: `User status changed to ${updatedUser.status}`,
      user: updatedUser,
    });
  } catch (error) {
    console.error('Toggle status error:', error);
    res.status(500).json({ error: error.message || 'Internal server error' });
  }
};


  
 

  exports.getStaff = async (req, res) => {
    const result = await adminService.getStaff();
    res.status(200).json(result);
  };
  
  exports.deleteStaff = async (req, res) => {
    const result = await adminService.deleteStaff(req.params.id);
    res.status(200).json(result);
  };

  exports.getPatients = async (req, res) => {
    const result = await adminService.getPatients();
    res.status(200).json(result);
  };

  exports.getTPatient = async (req, res) => {
    const result = await adminService.getTPatient();
    res.status(200).json(result);
  };

  exports.todayAppointment = async (req, res) => {
    const result = await adminService.todayAppointment();
    res.status(200).json(result);
  };

  exports.getTotalActiveStaff = async (req, res)=> {
    const result = await adminService.getTotalActiveStaff();
    res.status(200).json(result)
  }

  exports.getMonthlyRevenue = async(req, res) => {
    const result = await adminService.getMonthlyRevenue();
    res.status(200).json(result)
  }