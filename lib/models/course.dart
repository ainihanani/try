import 'package:flutter/material.dart';

class Course {
  String name;
  String thumbnail;
  String category;
  bool isCompleted;
  int watchedVideos;

  Course({
    required this.name,
    required this.thumbnail,
    required this.category,
    this.isCompleted = false,
    this.watchedVideos = 0,
  });

  // Function to update completion status and watched videos
  void markVideoAsWatched() {
    watchedVideos++;
    if (watchedVideos == 5) {
      isCompleted = true;
    }
  }
}

List<Course> courses = [
  Course(
    name: 'Introduction Basic Computer Components',
    thumbnail: 'assets/icons/laptop.jpg',
    category: 'Basic Computer Components',
  ),
  Course(
    name: 'Learn with Augmented Reality',
    thumbnail: 'assets/icons/accounting.jpg',
    category: 'AR',
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CoursesScreen(),
    );
  }
}

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return CourseCard(course: courses[index]);
        },
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Image.asset(
          course.thumbnail,
          width: 60,
          height: 60,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.name,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: course.isCompleted ? 1.0 : course.watchedVideos / 5,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ],
        ),
        subtitle: Text('Category: ${course.category}'),
        onTap: () {
          // Simulating marking a video as watched
          course.markVideoAsWatched();
          // Force a rebuild of the widget tree to reflect the updated completion status
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CoursesScreen()));
        },
      ),
    );
  }
}
