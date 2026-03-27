class DiaryEntry {
  final String path;      // 일기 txt 파일 저장 경로
  final String date;      // 일기 작성 날짜 (예: "2024-06-01")
  final String time;      // 일기 작성 시간 (예: "14:30")
  final String title;     // 일기 제목 (예: "오늘의 일기")

  const DiaryEntry({
    required this.path,
    required this.date,
    required this.time,
    required this.title,
  });
}