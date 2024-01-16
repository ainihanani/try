import 'package:flutter/material.dart';

class Lesson {
  final String title;
  final List<Map<String, String>> shortcuts;

  Lesson({
    required this.title,
    required this.shortcuts,
  });
}

List<Lesson> lessonList = [
  Lesson(
    title: 'General',
    shortcuts: [
      {'Shortcut': 'Ctrl + C', 'Description': 'Copy'},
      {'Shortcut': 'Ctrl + X', 'Description': 'Cut'},
      {'Shortcut': 'Ctrl + V', 'Description': 'Paste'},
      {'Shortcut': 'Ctrl + Z', 'Description': 'Undo'},
      {'Shortcut': 'Ctrl + Y', 'Description': 'Redo'},
      {'Shortcut': 'Ctrl + A', 'Description': 'Select All'},
      {'Shortcut': 'Ctrl + S', 'Description': 'Save'},
      {'Shortcut': 'Ctrl + N', 'Description': 'New (document or window)'},
      {'Shortcut': 'Ctrl + O', 'Description': 'Open'},
      {'Shortcut': 'Ctrl + P', 'Description': 'Print'},
      {'Shortcut': 'Ctrl + F', 'Description': 'Find'},
      {'Shortcut': 'Ctrl + H', 'Description': 'Replace'},
      {'Shortcut': 'Ctrl + E', 'Description': 'Center align (in text editors)'},
      {'Shortcut': 'Ctrl + L', 'Description': 'Left align (in text editors)'},
      {'Shortcut': 'Ctrl + R', 'Description': 'Right align (in text editors)'},
      {'Shortcut': 'Ctrl + B', 'Description': 'Bold (in text editors)'},
      {'Shortcut': 'Ctrl + I', 'Description': 'Italicize (in text editors)'},
      {'Shortcut': 'Ctrl + U', 'Description': 'Underline (in text editors)'},
      {'Shortcut': 'Ctrl + Home', 'Description': 'Go to the beginning of a document'},
      {'Shortcut': 'Ctrl + End', 'Description': 'Go to the end of a document'},
      {'Shortcut': 'Ctrl + Page Up', 'Description': 'Move to the previous page'},
      {'Shortcut': 'Ctrl + Page Down', 'Description': 'Move to the next page'},
      {'Shortcut': 'Alt + Tab', 'Description': 'Switch between open applications/windows'},
      {'Shortcut': 'Ctrl + Alt + Delete', 'Description': 'Open Task Manager (Windows)'},
      {'Shortcut': 'Cmd + Tab', 'Description': 'Switch between open applications (Mac)'},
      {'Shortcut': 'Cmd + Space', 'Description': 'Open Spotlight (Mac)'},
      {'Shortcut': 'Alt + F4', 'Description': 'Close the current window (Windows)'},
      {'Shortcut': 'Cmd + W', 'Description': 'Close the current window (Mac)'},
      {'Shortcut': 'Ctrl + Shift + Esc', 'Description': 'Open Task Manager (Windows)'},
      {'Shortcut': 'Windows Key + D', 'Description': 'Show/hide desktop (Windows)'},
    ],
  ),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Course2(),
    );
  }
}

class Course2 extends StatelessWidget {
  const Course2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shortcut Key'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const CustomTabView(tag: "Keyboard Shortcut Key"),
            const SizedBox(height: 20),
            Expanded(
              child: PlayList(lessonList: lessonList),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayList extends StatelessWidget {
  final List<Lesson> lessonList;

  const PlayList({Key? key, required this.lessonList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, __) => const SizedBox(
        height: 20,
      ),
      padding: const EdgeInsets.only(top: 20, bottom: 40),
      shrinkWrap: true,
      itemCount: lessonList.length,
      itemBuilder: (_, index) {
        return LessonCard(lesson: lessonList[index]);
      },
    );
  }
}

class CustomTabView extends StatelessWidget {
  final String tag;

  const CustomTabView({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade200,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              // Add logic here if needed
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.35,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                tag,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LessonCard extends StatelessWidget {
  final Lesson lesson;

  const LessonCard({Key? key, required this.lesson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(lesson.title),
        subtitle: DataTable(
          columns: const [
            DataColumn(label: Text('Shortcut')),
            DataColumn(label: Text('Description')),
          ],
          rows: lesson.shortcuts
              .map(
                (shortcut) => DataRow(
                  cells: [
                    DataCell(Text(shortcut['Shortcut']!)),
                    DataCell(Text(shortcut['Description']!)),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
