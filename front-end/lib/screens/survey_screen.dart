import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  double _val_1 = 10.0;
  double _val_2 = 20.0;
  bool visibility_1 = true;
  bool visibility_2 = false;

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
        children: [
          AnimatedOpacity(
            opacity: visibility_1 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Visibility(
              visible: visibility_1,
              child: SfSlider(
                value: _val_1,
                min: 0,
                max: 5,
                interval: 1,
                showTicks: true,
                onChangeEnd: (value) => setState(() {
                  visibility_2 = true;
                  visibility_1 = false;
                }),
                onChanged: (dynamic value) {
                  var val = value as double;
                  setState(
                    () {
                      _val_1 = val.round() as double;
                      print(_val_1);
                    },
                  );
                },
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: visibility_2 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Visibility(
              visible: visibility_2,
              child: SfSlider(
                activeColor: Colors.red,
                inactiveColor: Colors.red.withOpacity(0.2),
                value: _val_2,
                min: 0,
                max: 5,
                interval: 1,
                showTicks: true,
                onChanged: (dynamic value) {
                  var val = value as double;
                  setState(
                    () {
                      _val_2 = val.round() as double;
                      print(_val_2);
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
