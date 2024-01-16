class Lesson {
  String name;
  String duration;
  bool isPlaying;
  bool isCompleted;

  Lesson({
    required this.duration,
    required this.isCompleted,
    required this.isPlaying,
    required this.name,
  });
}

List<Lesson> lessonList = [
  Lesson(
    duration: '5 min',
    isCompleted: true,
    isPlaying: true,
    name: "Hardware basic",
  ),
  Lesson(
    duration: '5 min 11 sec',
    isCompleted: true,
    isPlaying: false,
    name: "Hardware basic",
  ),
  Lesson(
    duration: '7 min',
    isCompleted: true,
    isPlaying: false,
    name: "Hardware basic",
  ),
];