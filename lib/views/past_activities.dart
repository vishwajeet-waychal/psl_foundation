import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psl_foundation/services/ParticipatedActivitiesFunctions.dart';
import 'package:psl_foundation/views/activity_specific_analytic_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psl_foundation/views/widgets/appbar.dart';

import '../constant.dart';

class PastActivities extends StatefulWidget {
  const PastActivities({Key? key}) : super(key: key);

  @override
  State<PastActivities> createState() => _PastActivitiesState();
}

class _PastActivitiesState extends State<PastActivities> {
  List list = [];

  Future getData() async {
    ParticipatedActivitiesFunctions participatedActivitiesFunctions = ParticipatedActivitiesFunctions();
    list = await participatedActivitiesFunctions.getActivitiesParticipatedList(employeeId: kEmpID);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PFAppBar(
          title: "Past Activities", icon: FontAwesomeIcons.thumbtack),
      body: FutureBuilder(
        future: getData(),
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
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: kVerticalSpace, vertical: 4),
                    child: InkWell(
                      onTap: () {
                        Get.to(ActivitySpecificAnalyticPage(title: activity_data[index]['Title']));
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          tileColor: Colors.white,
                          leading: const CircleAvatar(
                            backgroundColor: kColorPrimary,
                            child: FaIcon(
                              FontAwesomeIcons.check,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            activity_data[index]['Title'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                                fontSize: 14,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Activity Owner : ${activity_data[index]['Activity_Owner']}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF79757F)),
                              ),
                              Text(
                                'Activity Date : ${activity_data[index]['Date']}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF79757F)),
                              ),
                              Text(
                                'Lives Touched : ${activity_data[index]['Lives_Touched']}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF79757F)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('No data'));
            }
          } else {
            return Center(child: Text('State: ${snapshot.connectionState}'));
          }
        },
      ),
    );
  }
}
