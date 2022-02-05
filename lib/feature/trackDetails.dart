class TrackDetails {
  final String title;
  final String duration;

  TrackDetails({required this.duration, required this.title});

  int trackDurationInMinutes() {
    final result = this.duration.split(":");

    int durationInMinutes = 0;

    //then duration is in hour
    if (result.length == 3) {
      durationInMinutes = (int.parse(result.first) * 60) + durationInMinutes;
      durationInMinutes = int.parse(result[1]) + durationInMinutes;
      durationInMinutes = (int.parse(result.last) ~/ 60) + durationInMinutes;
      return durationInMinutes;
    }

    //then duration is in minutes
    if (result.length == 2) {
      durationInMinutes = int.parse(result.first) + durationInMinutes;
      durationInMinutes = (int.parse(result.last) ~/ 60) + durationInMinutes;
    }

    durationInMinutes = (int.parse(result.first) ~/ 60) + durationInMinutes;
    return durationInMinutes;
  }
}
