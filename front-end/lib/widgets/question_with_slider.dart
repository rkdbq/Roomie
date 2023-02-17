import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class QuestionWithSlider extends StatefulWidget {
  late bool visibility;
  late double value;
  void onChanged(dynamic value) {}
  QuestionWithSlider({
    super.key,
    required this.visibility,
    required this.value,
  });

  @override
  State<QuestionWithSlider> createState() => _QuestionWithSliderState();
}

class _QuestionWithSliderState extends State<QuestionWithSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("hello"),
        SfSlider(
          value: widget.value,
          min: 0,
          max: 5,
          interval: 1,
          showTicks: true,
          onChangeEnd: (value) => setState(() {
            widget.visibility = false;
          }),
          onChanged: (value) {
            var val = value as double;
            setState(
              () {
                val = val.round() as double;
                print(val);
              },
            );
          },
        ),
      ],
    );
  }
}
