import 'package:flutter/material.dart';

extension TimeOfDayExtensionAdd on TimeOfDay {
  TimeOfDay add({int hour = 0, int minute = 0}) {
    return replacing(hour: this.hour + hour, minute: this.minute + minute);
  }
}

extension TimeOfDayExtensionSubtract on TimeOfDay {
  TimeOfDay subtract({int hour = 1, int minute = 0}) {
    return replacing(hour: this.hour - hour, minute: this.minute - minute);
  }
}
