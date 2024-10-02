import 'package:flutter/material.dart';
import 'dart:async';

class StopwatchProvider extends ChangeNotifier {
  Timer? _timer;
  Duration _elapsedTime = Duration.zero;

  bool isStart = false;
  bool isPause = false;

  List<Map<String, String>> lapsList = [];

  Duration get elapsedTime => _elapsedTime;

  String timeFormat(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String threeDigits(int n) => n.toString().padLeft(3, '0');

    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    String milliseconds = threeDigits(duration.inMilliseconds.remainder(1000));

    return '$hours:$minutes:$seconds:$milliseconds';
  }

  void startWatch() {
    if (isStart) return;

    _timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      _elapsedTime += const Duration(milliseconds: 1);
      notifyListeners();
    });
    isStart = true;
    isPause = false;
    notifyListeners();
  }

  void pauseWatch() {
    _timer?.cancel();
    isStart = false;
    isPause = true;
    notifyListeners();
  }

  void resetWatch() {
    _timer?.cancel();
    _elapsedTime = Duration.zero;
    lapsList.clear();
    isStart = false;
    isPause = false;
    notifyListeners();
  }

  void stopWatch() {
    _timer?.cancel();
    _elapsedTime = Duration.zero;
    isStart = false;
    isPause = false;
    notifyListeners();
  }

  void addLap() {
    if (isStart) {
      lapsList.add({
        'lap': 'LAP ${lapsList.length + 1}',
        'time': timeFormat(_elapsedTime),
      });
      notifyListeners();
    }
  }
}
