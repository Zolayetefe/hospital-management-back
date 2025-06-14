const authService = require('../services/authService');

exports.login = async (req, res) => {
  try {
    const { token, message, user } = await authService.login(req.body);

    // Send token in response body (client should store and send in Authorization header)
    res.status(200).json({
      message,
      user,
      token, 
    });

  } catch (err) {
    res.status(400).json({ message: err.message });
  }
};


exports.getme = async (req, res) => {
  try {
    const userId = req.user.id;
    // console.log("req.user from getme",req.user.id)
    const {user} = await authService.getme(userId)
 
    // return {

    //   user: {
    //     id: user.id,
    //     name:user.name,   
    //     email: user.email,
    //     role: user.role
       
    //   },
    // }
    res.status(200).json({ user });
  } catch (err) { 
    res.status(400).json({ message: err.message });
  }
};


exports.registerPatient= async (req,res)=>{
  try {
    const{message,user}= await authService.registerPatient(req.body)
    // console.log("user from register patient",user)
    res.status(200).json({message,user})
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
}

 exports.registerStaff = async (req, res) => {
    try {
      console.log("from controller",req.body)
      const result = await authService.registerStaff(req.body);
    
      res.status(201).json(result);
    } catch (err) {
      res.status(400).json({ message: err.message });
    }
  };

exports.changePassword = async (req, res) => {
  try {
    const { oldPassword, newPassword } = req.body;
    const userId = req.user.id; // Assumes you're using middleware to set req.user

    const result = await authService.changePassword({ userId, oldPassword, newPassword });

    res.status(200).json(result);
  } catch (err) {
    console.error('Change password error:', err);
    res.status(400).json({ error: err.message });
  }
};

exports.updateProfile = async (req, res) => {
  try {
    const userId = req.user.id;
    const data = req.body;

    const result = await authService.updateProfile(userId, data);
    res.json(result);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};