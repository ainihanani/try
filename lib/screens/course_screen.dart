import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_apps/models/course.dart';
import 'package:learn_apps/screens/details_screen.dart';
import 'package:learn_apps/screens/learning_base.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key}) : super(key: key);

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicHeight(
                  child: Stack(
                    children: [
                      Align(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Basic Computer Components',
                              
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left :  20,
                        child: CustomIconButton(
                          height: 35,
                          width: 35,
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    separatorBuilder: (_, __) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    shrinkWrap: true,
                    itemBuilder: (_, int index) {
                      return CourseContainer(
                        course: courses[index],
                        onTap: () {
                          if (courses[index].category == 'AR') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LearningBasePage(),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CourseDetailsScreen(
                                  title: courses[index].name,
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                    itemCount: courses.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CourseContainer extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;

  const CourseContainer({
    Key? key,
    required this.course,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                course.thumbnail,
                height: 60,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(course.name),
                  const SizedBox(
                    height: 5,
                  ),
                  // Removed the VideoCompletionIndicator
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
