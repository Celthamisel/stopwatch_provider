import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'stopwatch_provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final stopwatchProvider = Provider.of<StopwatchProvider>(context);
    Color bgcolor = const Color(0xFFF6F8FE);
    Color secondry = const Color(0xFFECEFF9);
    Color highlight = const Color(0xFFE7EBF7);

    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.only(left: 25, top: 20),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 30,
            ),
          ),
          title: Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 15, right: 55, bottom: 5),
            child: Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                  color: secondry, borderRadius: BorderRadius.circular(360)),
              child: const Center(
                child: Text(
                  'StopWatch',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ))),

      // body
      body: Column(
        children: [
          // Timer
          Padding(
            padding: const EdgeInsets.only(top: 110),
            child: Center(
              child: InkWell(
                onTap: () {
                  stopwatchProvider.addLap();
                },
                child: Container(
                  height: 270,
                  width: 270,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(360),
                    boxShadow: List.filled(
                        10, BoxShadow(color: highlight, blurRadius: 30)),
                  ),
                  child: Center(
                    child: Text(
                      stopwatchProvider.timeFormat(stopwatchProvider.elapsedTime),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontFamily: 'Redex'),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // List - Laps
          SizedBox(
            width: double.infinity,
            height: 250,
            child: ListView.builder(
              itemCount: stopwatchProvider.lapsList.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 10, right: 10, top: 80),
              itemBuilder: (context, index) {
                final lapsItem = stopwatchProvider.lapsList[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 30, left: 10, right: 5),
                  child: Container(
                    height: 120,
                    width: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10, right: 10),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 15),
                          child: Text(
                            lapsItem['lap'] ?? 'Lap Unknown', // Null-aware
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Redex',
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 15),
                          child: Text(
                            lapsItem['time'] ?? 'Time Unknown', // Null-aware
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontFamily: 'Ubuntu',
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                // Button 1 - Start, Pause, Resume
                Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: InkWell(
                      onTap: () {
                        if (stopwatchProvider.isStart) {
                          stopwatchProvider.pauseWatch();
                        } else {
                          stopwatchProvider.startWatch();
                        }
                      },
                      child: Container(
                        height: 70,
                        width: 160,
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(360),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              stopwatchProvider.isStart
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              color: Colors.grey.shade300,
                              size: 35,
                            ),
                            Container(
                              width: 10,
                            ),
                            Text(
                              stopwatchProvider.isStart
                                  ? 'PAUSE'
                                  : stopwatchProvider.isPause
                                      ? 'RESUME'
                                      : 'START',
                              style: TextStyle(
                                color: Colors.grey.shade300,
                                fontSize: 19,
                                fontFamily: 'Ubuntu',
                              ),
                            )
                          ],
                        ),
                      ),
                    )),

                const Spacer(),

                // Button 2 - Reset, Stop
                Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: InkWell(
                      onTap: () {
                        if (stopwatchProvider.isStart) {
                          stopwatchProvider.stopWatch();
                        } else {
                          stopwatchProvider.resetWatch();
                        }
                      },
                      child: Container(
                        height: 70,
                        width: 160,
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(360),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              stopwatchProvider.isStart
                                  ? Icons.stop_rounded
                                  : Icons.restart_alt,
                              color: Colors.grey.shade300,
                              size: 35,
                            ),
                            Container(
                              width: 10,
                            ),
                            Text(
                              stopwatchProvider.isStart ? 'STOP' : 'RESET',
                              style: TextStyle(
                                color: Colors.grey.shade300,
                                fontSize: 19,
                                fontFamily: 'Ubuntu',
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
