import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psl_foundation/constant.dart';
import 'package:psl_foundation/views/widgets/appbar.dart';

import 'graph_screen.dart';

class ActivitySpecificAnalyticPage extends StatelessWidget {
  const ActivitySpecificAnalyticPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PFAppBar(
        title: title,
        icon: FontAwesomeIcons.chartLine,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 14,
              childAspectRatio: 0.7,
              padding: const EdgeInsets.all(9.0),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: kColorPrimary,
                      borderRadius: BorderRadius.circular(8.0)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '290',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'No. Of Participants',
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
                    children: const [
                      Text(
                        '23',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'One Time Participants',
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
                    children: const [
                      Text(
                        '60',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'CP BU Participation',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0)
                ),
                shadowColor: Colors.grey.shade50,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                            'Lives touched per activity',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      PieChartSample3(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
