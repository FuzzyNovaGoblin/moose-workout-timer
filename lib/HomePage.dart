import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moose_timer/ClkTimer.dart';
import 'package:moose_timer/TimerRunnerPage.dart';
import 'package:moose_timer/TimerOptionsDialog.dart';

final listKey = GlobalKey<AnimatedListState>();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Duration> timerSegments;

  @override
  void initState() {
    super.initState();
    timerSegments = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: ActionChip(
              label: Text("add segment"),
              onPressed: () {
                timerSegments.add(Duration.zero);
                setState(() => listKey.currentState?.insertItem(timerSegments.length - 1));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: ActionChip(
              label: Text("start"),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TimerRunnerPage(timerSegments.map((e) => ClkTimer(duration: e)).toList()))),
            ),
          ),
        ],
      ),
      body: AnimatedList(
        key: listKey,
        initialItemCount: timerSegments.length,
        itemBuilder: (context, index, animation) => SizeTransition(
          sizeFactor: animation,
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.85,
              child: GestureDetector(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => TimerOptionDialog(timerSegments[index]),
                ).then((value) {
                  if (value == null) return;
                  timerSegments[index] = value;
                  setState(() {});
                }),
                child: Dismissible(
                  onDismissed: (_) {
                    timerSegments.removeAt(index);
                    setState(() {
                      AnimatedList.of(context).removeItem(index, (_, __) => Container());
                    });
                  },
                  key: ValueKey(timerSegments[index]),
                  child: Card(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          timeParse(timerSegments[index]),
                          style: TextStyle(fontSize: 50),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
