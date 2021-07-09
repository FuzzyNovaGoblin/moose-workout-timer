import 'package:flutter/material.dart';
import 'package:moose_timer/ClkTimer.dart';

import 'TimeTextField.dart';

class TimerOptionDialog extends StatefulWidget {
  final Duration timerDur;

  const TimerOptionDialog(
    this.timerDur, {
    Key? key,
  }) : super(key: key);
  @override
  _TimerOptionDialogState createState() => _TimerOptionDialogState();
}

class _TimerOptionDialogState extends State<TimerOptionDialog> {
  late TextEditingController secondController;
  late TextEditingController minuteController;

  @override
  void initState() {
    super.initState();
    secondController = TextEditingController(text: (widget.timerDur.inSeconds % 60).toString());
    minuteController = TextEditingController(text: widget.timerDur.inMinutes.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4), side: BorderSide(color: Colors.white, width: 3)),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TimeTextField(minuteController),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Icon(
                    Icons.fiber_manual_record,
                    size: 13,
                  ),
                  Icon(
                    Icons.fiber_manual_record,
                    size: 13,
                  ),
                ],
              ),
            ),
            TimeTextField(secondController),
          ],
        ),
        ButtonBar(
          children: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("OK"),
              onPressed: () {
                try {
                  Navigator.pop(
                    context,
                    Duration(minutes: int.parse(minuteController.text), seconds: int.parse(secondController.text)),
                  );
                } catch (_) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("invalid data"),
                    duration: Duration(milliseconds: 800),
                  ));
                }
              },
            ),
          ],
        )
      ],
    );
  }
}
