import 'package:flutter/material.dart';
import 'package:psl_foundation/views/widgets/appbar.dart';
class PastActivities extends StatelessWidget {
  const PastActivities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PFAppBar(title: "Past Activities"),
      body: Container(),
    );
  }
}
