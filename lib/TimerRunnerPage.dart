import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moose_timer/ClkTimer.dart';
import 'package:audioplayers/audioplayers.dart';

class TimerRunnerPage extends StatefulWidget {
  final List<ClkTimer> timerSegments;

  const TimerRunnerPage(this.timerSegments, {Key? key}) : super(key: key);

  @override
  _TimerRunnerPageState createState() => _TimerRunnerPageState();
}

class _TimerRunnerPageState extends State<TimerRunnerPage> {
  late List<ClkTimer> timerSegments;
  ClkTimer? currentTimmer;
  late Timer drawTimer;
  late bool first;

  late AudioCache audioCache;
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    first = true;

    audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
    audioCache = AudioCache();

    drawTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (currentTimmer == null) {
        Navigator.pop(context);
      } else
        setState(() {});
    });
    timerSegments = List.from(widget.timerSegments);
    currentTimmer = ClkTimer(duration: Duration(seconds: 3));

    audioCache.play(
      'ready.mp3',
    );
  }

  @override
  void dispose() {
    drawTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (currentTimmer != null && currentTimmer!.remainingTime <= Duration.zero) {
      currentTimmer = timerSegments.length > 0 ? timerSegments.removeAt(0) : null;
      if (first) {
        first = false;
        audioCache.play(
          'go.mp3',
        );
      } else {
        audioCache.play(
          'beep.mp3',
        );
      }
    }

    if (currentTimmer == null) {
      //play complete sound

      // .pop(context);
      return Container();
    }

    currentTimmer!.start();
    return Scaffold(
      body: SizedBox.expand(
          child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          timeParse(currentTimmer!.remainingTime),
          style: GoogleFonts.ubuntu(),
        ),
      )),
    );
  }
}
