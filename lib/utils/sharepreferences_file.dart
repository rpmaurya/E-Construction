import 'package:shared_preferences/shared_preferences.dart';

class SharepreferencClass {
  saveUser(String token, int userId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', token);
    await pref.setInt('userId', userId);
  }
  // Future<void> saveUser(OtpVerifyModel data) async {
  //   OtpVerifyModel? setDat;
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   OtpVerifyModel setdata = OtpVerifyModel.fromJson(d);
  //   await pref.setString('token', setdata);
  //   // await pref.setInt('userId', userI);
  // }

  getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.getString('token');
    await pref.getInt('userId');
  }

  clearData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}
