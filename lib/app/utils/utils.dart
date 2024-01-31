import 'dart:async';

class Utils {
  static Timer setTimeout(callback, time) {
    Duration timeDelay = Duration(milliseconds: time);
    return Timer(timeDelay, callback);
  }
}
