import 'package:psl_foundation/services/HomeScreenFunctions.dart';

class HomeScreenDataService {

  static Future<List> getData() async {
    HomeScreenFunctions homeScreenFunctions = HomeScreenFunctions();
    return await homeScreenFunctions.fetchLiveActivities();
  }
}