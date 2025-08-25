extension IntExtension on int {
  bool isWithin(int rangeStart, int rangeEnd) {
    return !(this < rangeStart || this > rangeEnd);
  }
}
