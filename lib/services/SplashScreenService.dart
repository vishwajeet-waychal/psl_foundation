import 'package:get_storage/get_storage.dart';
import '../constant.dart';

class LoggedInUserService {

  static Future<bool> isUserLoggedIn() async {
    final box = GetStorage();

    Map<String, dynamic> data = await box.read('userData') == null ? {} : box.read('userData');

    if (data.isNotEmpty) {
      kEmpID = data['empId'];
      appMode = data['userType'];
      return true;
    }
    return false;
  }
}