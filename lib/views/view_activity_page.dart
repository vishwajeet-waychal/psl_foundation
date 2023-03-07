import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:psl_foundation/constant.dart';
import 'package:psl_foundation/services/HomeScreenFunctions.dart';
import 'package:psl_foundation/views/registered_participants_page.dart';
import 'package:psl_foundation/views/widgets/appbar.dart';
import 'package:psl_foundation/views/register_for_activity.dart';
import 'package:psl_foundation/views/widgets/custom_raised_button.dart';

import '../Data/task.dart';
import '../services/EmployeeFunctions.dart';

class ViewActivityPage extends StatefulWidget {
  var activityData;
  ViewActivityPage({required this.activityData});

  @override
  _ViewActivityPageState createState() => _ViewActivityPageState();
}

class _ViewActivityPageState extends State<ViewActivityPage> {
  bool? isHeartIconTapped = false;
  // bool activityType = widget.activityData[""]; //assign directly from database
  late HomeScreenFunctions homeScreenFunctions;
  late List<dynamic> like;

  @override
  void initState() {
    super.initState();
    like = widget.activityData['Like'];
    homeScreenFunctions = HomeScreenFunctions();

    if (like.contains(int.parse(kEmpID))) {
      isHeartIconTapped = true;
    }
  }

  String isDonationActivity() {
    if (appMode == "Admin") {
      return "See Registered Participants";
    } else {
      if (widget.activityData["Activity_Type"] == "Donation Drive") {
        return "Donate";
      } else {
        return "Volunteer";
      }
    }
  }

  void storeData(String employeeId, var activity, int amountDonated) async {
    EmployeeFunctions employeeFunctions = EmployeeFunctions();
    await employeeFunctions.registerDonation(employeeId: employeeId, activity: activity, amountDonated: amountDonated);
  }

  void onHeartIconTapped() {
    setState(() {
      isHeartIconTapped = !isHeartIconTapped!;
    });
  }

  final GlobalKey<FormBuilderState> _donationAmountKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PFAppBar(
        title: "Activity",
        icon: Icons.local_activity,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Hero(
                          tag: "Activity Title",
                          child: Text(
                              widget.activityData["Title"],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.activityData["Activity_Type"],
                    style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 180,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          width: 280,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.0),
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/psl_activty_img.jpg"),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 280,
                          decoration: BoxDecoration(
                            color: kColorPrimary,
                            borderRadius: BorderRadius.circular(14.0),
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                "assets/images/psl_activty_img2.jpg",
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () async {
                            onHeartIconTapped();
                            if (isHeartIconTapped!) {
                              homeScreenFunctions.addLike(empId: kEmpID, activityId: widget.activityData['Activity_Id']);
                            } else {
                              homeScreenFunctions.removeLike(empId: kEmpID, activityId: widget.activityData['Activity_Id']);
                            }
                          },
                          child: Icon(
                            FontAwesomeIcons.handsClapping,
                            color: isHeartIconTapped!
                                ? kColorPrimary
                                : Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 1),
                            color: Colors.white.withOpacity(0.1),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              // Call whatsapp chat link and route to join the group
                              print(widget.activityData["Whatsapp_Chat_Link"]);
                            },
                            child: const Icon(
                              FontAwesomeIcons.whatsapp,
                              color: kColorPrimary,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 42,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 5),
                              child: Text(
                                  widget.activityData["Lives_Touched"].toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                  )
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Text(
                                  "Lives Touched",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      // Container(
                      //   height: 42,
                      //   width: 105,
                      //   decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.black, width: 1),
                      //     borderRadius: BorderRadius.circular(10),
                      //     color: Colors.white.withOpacity(0.1),
                      //   ),
                      //   child: Row(
                      //     children: const <Widget>[
                      //       Padding(
                      //         padding: EdgeInsets.only(left: 10),
                      //         child: Text("18",
                      //             style: TextStyle(
                      //                 color: Colors.black,
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 20)),
                      //       ),
                      //       Spacer(
                      //         flex: 2,
                      //       ),
                      //       Padding(
                      //         padding: EdgeInsets.only(right: 5),
                      //         child: Text("Registered\nParticipants",
                      //             style: TextStyle(
                      //                 color: Colors.black,
                      //                 fontWeight: FontWeight.w100,
                      //                 fontSize: 10)),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(50.0)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: Row(
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.locationDot,
                              size: 14,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.activityData["Location"],
                              style: const TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(50.0)
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      child: Row(
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.calendar,
                            size: 14,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.activityData["Date"].toString(),
                            style: const TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Activity Owner: ${widget.activityData["Activity_Owner"]}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.activityData["Description"]
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 87,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 0, 0, 0),
                    gradient: LinearGradient(
                        stops: [
                          0,
                          1
                        ],
                        colors: [
                          Color(0xff121421),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: PFRaisedButton(
                    title: isDonationActivity(),
                    onPressed: () async {
                      if (appMode == "Admin") {
                        Get.to(() => RegisteredPage(
                            widget.activityData["Activity_Id"]));
                      } else {
                        if (widget.activityData["Activity_Type"] ==
                            "Donation Drive") {
                          final task = await Get.bottomSheet(
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                  MediaQuery.of(context).viewInsets.bottom,
                                  top: kDefaultSpace,
                                  right: kDefaultSpace,
                                  left: kDefaultSpace
                              ),

                              child: SingleChildScrollView(
                                child: FormBuilder(
                                  key: _donationAmountKey,
                                  child: Column(children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: FormBuilderTextField(
                                        name: "Donation_Amount",
                                        autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                        decoration: const InputDecoration(
                                            labelText: "Add Donation Amount",
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Colors.black26))),
                                        validator:
                                        FormBuilderValidators.compose([
                                          FormBuilderValidators.required()
                                        ]),
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    PFRaisedButton(title: "Add Task",
                                        onPressed: (){
                                          _donationAmountKey.currentState?.saveAndValidate();
                                          storeData(kEmpID, widget.activityData, int.parse(_donationAmountKey.currentState?.fields['Donation_Amount']?.value));
                                          Get.back();
                                        }),
                                    SizedBox(height: 10,)
                                  ]),),
                              ),
                            ),
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10)
                              ),
                            ),

                          );
                        } else {
                          Get.to(() => RegisterForActivity(tasks: widget.activityData['Task'], activityData: widget.activityData,));
                        }
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
