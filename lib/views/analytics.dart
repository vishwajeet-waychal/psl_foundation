import 'package:flutter/material.dart';
import 'package:psl_foundation/services/OverallAnalyticsFunctions.dart';
import 'package:psl_foundation/views/graph_screen.dart';
import 'package:psl_foundation/views/widgets/appbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psl_foundation/views/widgets/dot_indicator.dart';

import '../constant.dart';
import 'bar_graph.dart';

class Analytics extends StatefulWidget {
  const Analytics({Key? key}) : super(key: key);

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {

  Map<String, Object> topEmp = {};
  int totalLivesTouched = 0;
  Map<String, int> top3VolActivity = {};
  Map<String, int> top3DonatedActivity = {};
  OverallAnalyticsFunctions overallAnalyticsFunctions = OverallAnalyticsFunctions();

  getStarEmployee() async {
    topEmp = await overallAnalyticsFunctions.getTopEmployee();
    setState(() {});
  }

  getTotalLivesTouched() async {
    totalLivesTouched = await overallAnalyticsFunctions.totalLivesTouched();
    setState(() {});
  }

  getTop3VolActivity() async {
    top3VolActivity = Map<String, int>.fromEntries(await overallAnalyticsFunctions.getTop3VolunteeredActivities());
    setState(() {});
  }

  getTop3DonatedActivity() async {
    top3DonatedActivity = Map<String, int>.fromEntries(await overallAnalyticsFunctions.getTop3DonatedActivities());
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getStarEmployee();
    getTotalLivesTouched();
    getTop3VolActivity();
    getTop3DonatedActivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PFAppBar(title: "Analytics", icon: FontAwesomeIcons.chartLine),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 13,
              childAspectRatio: 1.5,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(13.0),
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: kColorPrimary,
                      borderRadius: BorderRadius.circular(8.0)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        topEmp['Name'].toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Star Employee",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      Text(
                        "${topEmp['count']} lives touched",
                        style: const TextStyle(
                            color: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: kColorPrimary,
                      borderRadius: BorderRadius.circular(8.0)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        totalLivesTouched.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Lives touched by PSL",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Top 3 volunteered activity',
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: DotIndicator(),
                        ),
                        Expanded(
                          child: Text(
                              'Tree Plantation - ${top3VolActivity['V0002']}'
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: DotIndicator(),
                        ),
                        Expanded(
                          child: Text(
                              'Old Age Home Visit - ${top3VolActivity['V0003']}'
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: DotIndicator(),
                        ),
                        Expanded(
                          child: Text(
                              'Outdoor and environmental project - ${top3VolActivity['V0001']}'
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const Text(
                      'Top 3 donated activity',
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: DotIndicator(),
                        ),
                        Expanded(
                          child: Text(
                              'School supply donation - ${top3DonatedActivity['D0002']}'
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: DotIndicator(),
                        ),
                        Expanded(
                          child: Text(
                              'Drinking water donation - ${top3DonatedActivity['D0005']}'
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: DotIndicator(),
                        ),
                        Expanded(
                          child: Text(
                              'Orphanage home donation - ${top3DonatedActivity['D0001']}'
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0)
                ),
                clipBehavior: Clip.hardEdge,
                shadowColor: Colors.grey.shade50,
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: kColorPrimary,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text(
                              'Employee count for both activities',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 14, top: 8),
                      child: PieChartSample2(),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(8.0),
                    //   child: Text(
                    //     'Employee count for both activities',
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.bold
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0)
                ),
                clipBehavior: Clip.hardEdge,
                shadowColor: Colors.grey.shade50,
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: kColorPrimary,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text(
                              'Lives touched per activity',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 14, top: 8),
                      child: PieChartSample3(),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(8.0),
                    //   child: Text(
                    //       'Lives touched per activity',
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.bold
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0)
                ),
                clipBehavior: Clip.hardEdge,
                shadowColor: Colors.grey.shade50,
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: kColorPrimary,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text(
                              'Grade-vise Employees for both activities',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    BarChartSample7(),
                    // const Padding(
                    //   padding: EdgeInsets.all(8.0),
                    //   child: Text(
                    //       'Grade-vise Employees for both activities',
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.bold
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Card(
            //     elevation: 4,
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(14.0)
            //     ),
            //     shadowColor: Colors.grey.shade50,
            //     child: Column(
            //       children: [
            //         Container(
            //           height: 150,
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Text(
            //               'OU-vise Employees for both activities'
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
