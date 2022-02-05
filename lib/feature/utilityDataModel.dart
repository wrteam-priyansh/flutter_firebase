class UtilityDataModel {
  final String startTime;
  final String startDate;
  final String playlistUrl;

  UtilityDataModel(
      {required this.playlistUrl,
      required this.startDate,
      required this.startTime});

  UtilityDataModel copyWith(
      {String? newStartTime, String? newStartDate, String? newPlaylistUrl}) {
    return UtilityDataModel(
        playlistUrl: newPlaylistUrl ?? this.playlistUrl,
        startDate: newStartDate ?? this.startDate,
        startTime: newStartTime ?? this.startTime);
  }
}
