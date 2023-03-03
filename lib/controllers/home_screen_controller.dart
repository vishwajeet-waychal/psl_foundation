import 'package:get/get.dart';
import 'package:psl_foundation/services/HomeScreenDataService.dart';

class HomeScreenController extends GetxController {

  final dataList = Future.value().obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  refreshData(){
    fetchData();
  }

  fetchData() {
    dataList.value = HomeScreenDataService.getData();
  }

}