const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');
const { isAuthenticated ,isAdmin} = require('../middlewares/authMiddleware');

// Define routes
router.post('/login', authController.login);
router.get('/me', isAuthenticated, authController.getme);
router.post('/change-password', isAuthenticated, authController.changePassword);
router.put('/update-profile', isAuthenticated, authController.updateProfile);


// patient registration
router.post('/patient/register', authController.registerPatient);
//staff registration
router.post('/staff/register', isAuthenticated, isAdmin, authController.registerStaff);

module.exports = router;
