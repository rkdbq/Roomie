import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  List<double> values = [2, 0];
  List<bool> visibility = [true, false];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeff1f3),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            opacity: visibility[0] ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Visibility(
              visible: visibility[0],
              child: SfSlider(
                activeColor: Colors.red,
                inactiveColor: Colors.red.withOpacity(0.2),
                value: values[0],
                min: 0,
                max: 5,
                interval: 1,
                showTicks: true,
                onChangeEnd: (value) => setState(
                  () {
                    visibility[0] = false;
                    visibility[1] = true;
                  },
                ),
                onChanged: (dynamic value) {
                  var val = value as double;
                  setState(
                    () {
                      values[0] = val.round() as double;
                      print(values[0]);
                    },
                  );
                },
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: visibility[1] ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Visibility(
              visible: visibility[1],
              child: SfSlider(
                activeColor: Colors.blue,
                inactiveColor: Colors.blue.withOpacity(0.2),
                value: values[1],
                min: 0,
                max: 5,
                interval: 1,
                showTicks: true,
                onChangeEnd: (value) => setState(
                  () {
                    //visibility[0] = false;
                  },
                ),
                onChanged: (dynamic value) {
                  var val = value as double;
                  setState(
                    () {
                      values[1] = val.round() as double;
                      print(values[1]);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      )),
    );
  }
}
