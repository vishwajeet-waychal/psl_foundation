import 'package:flutter/material.dart';
import 'package:psl_foundation/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psl_foundation/services/ActivitySpecificAnalyticsFunctions.dart';
import 'package:psl_foundation/services/EmployeeFunctions.dart';
import 'package:psl_foundation/views/widgets/appbar.dart';

class RegisteredPage extends StatefulWidget {
  var activityId;
  RegisteredPage(this.activityId);

  @override
  State<RegisteredPage> createState() => _RegisteredPageState();
}

class _RegisteredPageState extends State<RegisteredPage> {
  List empIdList = [];
  List empList = [];

  Future getData() async {
    ActivitySpecificAnalyticsFunctions activitySpecificAnalyticsFunctions = ActivitySpecificAnalyticsFunctions();
    EmployeeFunctions employeeFunctions = EmployeeFunctions();
    empIdList = await activitySpecificAnalyticsFunctions.fetchParticipatedEmployeeList(widget.activityId);
    for (int empId in empIdList) {
      var temp = await employeeFunctions.fetchEmployee(employeeId: empId.toString());
      empList.add(temp);
    }
    return empList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PFAppBar(
          title: "Registered Participants", icon: FontAwesomeIcons.calendar),
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
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        margin: const EdgeInsets.symmetric(horizontal: kVerticalSpace, vertical: 4),
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
                            backgroundImage:
                            AssetImage('assets/images/avtar_image.jpg'),
                          ),
                          title: Text(
                            '${snapshot.data[index]["First_Name"]} ${snapshot.data[index]["Last_Name"]}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'BU : ${snapshot.data[index]["BU"]}',
                                style: const TextStyle(
                                    color: Color(0xFF79757F),
                                  fontSize: 12
                                ),
                              ),
                              Text(
                                'Grade : ${snapshot.data[index]["Grade"]}',
                                style: const TextStyle(
                                    color: Color(0xFF79757F),
                                  fontSize: 12
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
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
