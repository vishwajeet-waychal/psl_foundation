import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psl_foundation/views/add_activity.dart';
import 'package:psl_foundation/views/widgets/appbar.dart';
import 'package:get/get.dart';
import 'package:psl_foundation/views/widgets/home_screen_card.dart';

import '../constant.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('activities').snapshots(),
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
              List liveActivities = [];
              final allActivities = snapshot.data!.docs
                  .map((doc) => doc.data() as Map<String, dynamic>)
                  .toList();
              for (Map<String, dynamic> activity in allActivities) {
                DateTime now = DateTime.now();
                DateTime date = DateTime.parse(activity["Date"]);
                if (now.isBefore(date)) {
                  liveActivities.add(activity);
                }
              }
              return ListView.builder(
                itemCount: liveActivities.length,
                itemBuilder: (context, index) {
                  return PFHomeScreenCard(
                      activityId: liveActivities[index]['Activity_Id'],
                      title: liveActivities[index]['Title'],
                      subHeading: liveActivities[index]['Activity_Type'],
                      imgUrl: liveActivities[index]['ImageURL'],
                      date: liveActivities[index]['Date'],
                      desc: liveActivities[index]['Description'],
                      like: liveActivities[index]['Like'],
                      likeCount: liveActivities[index]['Like'].length,
                      location: liveActivities[index]['Location'],
                      activityData: liveActivities[index]);
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
  }
}
