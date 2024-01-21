import 'package:flutter/material.dart';
import 'package:learn_apps/constants/size.dart';
import 'package:learn_apps/homie.dart';
import 'package:learn_apps/models/category.dart';
import 'package:learn_apps/models/course2.dart';
import 'package:learn_apps/screens/course_screen.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (category.name == 'Basic Computer Components') {
          // Navigate to CourseScreen for Basic Components
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CourseScreen(),
            ),
          );
        } else if (category.name == 'ShortcutKey') {
          // Navigate to Course2 for Short key
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Course2(),
            ),
          );
        } else if (category.name == 'Quiz') {
          // Navigate to QuizScreen for Quiz
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => homepage(),
            ),
          );
        }
      },

      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 4.0,
              spreadRadius: .05,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                category.thumbnail,
                height: kCategoryCardImageSize,
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            Text(category.name),
            Text(
              "${category.noOfCourses.toString()} courses",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}