import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psl_foundation/controllers/home_screen_controller.dart';
import 'package:psl_foundation/views/add_activity.dart';
import 'package:psl_foundation/views/widgets/appbar.dart';
import 'package:get/get.dart';
import 'package:psl_foundation/views/widgets/home_screen_card.dart';

import '../constant.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  HomeScreenController homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PFAppBar(title: "Home", icon: FontAwesomeIcons.house),
      floatingActionButton: appMode != "User"
          ? FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddActivity());
        },
        child: const Text(
          "+",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ) : Container(),
      body: Obx(() {
        return RefreshIndicator(
          onRefresh: () async {
            homeScreenController.refreshData();
          },
          child: FutureBuilder(
            future: homeScreenController.dataList.value,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Error'));
                } else if (snapshot.hasData) {
                  List activity_data = snapshot.data;
                  return ListView.builder(
                    itemCount: activity_data.length,
                    itemBuilder: (context, index) {
                      return PFHomeScreenCard(
                          title: activity_data[index]['Title'],
                          subHeading: activity_data[index]['Activity_Type'],
                          imgUrl: activity_data[index]['ImageURL'],
                          date: activity_data[index]['Date'],
                          desc: activity_data[index]['Description'],
                          likeCount: activity_data[index]['Like'].length,
                          location: activity_data[index]['Location'],
                          activityData: activity_data[index]);
                    },
                  );
                } else {
                  return const Center(child: Text('No data'));
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          ),
        );
      }),
    );
  }
}




//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   List list = [];
//
//   Future getData() async {
//     HomeScreenFunctions homeScreenFunctions = HomeScreenFunctions();
//     list = await homeScreenFunctions.fetchLiveActivities();
//     return list;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   HomeScreenController homeScreenController = Get.put(HomeScreenController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const PFAppBar(title: "Home", icon: FontAwesomeIcons.house),
//       floatingActionButton: appMode != "User"
//           ? FloatingActionButton(
//               onPressed: () {
//                 Get.to(() => const AddActivity());
//               },
//               child: const Text(
//                 "+",
//                 style: TextStyle(fontSize: 30, color: Colors.white),
//               ),
//             )
//           : Container(),
//       body: FutureBuilder(
//         future: getData(),
//         builder: (context, AsyncSnapshot snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.connectionState == ConnectionState.active ||
//               snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasError) {
//               return const Center(child: Text('Error'));
//             } else if (snapshot.hasData) {
//               List activity_data = snapshot.data;
//               return ListView.builder(
//                 itemCount: activity_data.length,
//                 itemBuilder: (context, index) {
//                   return PFHomeScreenCard(
//                       title: activity_data[index]['Title'],
//                       subHeading: activity_data[index]['Activity_Type'],
//                       imgUrl: activity_data[index]['ImageURL'],
//                       date: activity_data[index]['Date'],
//                       desc: activity_data[index]['Description'],
//                       likeCount: activity_data[index]['Like'].length,
//                       location: activity_data[index]['Location'],
//                       activityData: activity_data[index]);
//                 },
//               );
//             } else {
//               return const Center(child: Text('No data'));
//             }
//           } else {
//             return Text('State: ${snapshot.connectionState}');
//           }
//         },
//       ),
//     );
//   }
// }
