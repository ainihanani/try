class CourseProgressTracker {
  List<bool> courseCompletionStatus;

  CourseProgressTracker(int numberOfCourses)
      : courseCompletionStatus = List<bool>.filled(numberOfCourses, false);

  void markCourseAsCompleted(int index) {
    if (index >= 0 && index < courseCompletionStatus.length) {
      courseCompletionStatus[index] = true;
    }
  }

  bool isProgramCompleted() {
    return courseCompletionStatus.every((completed) => completed);
  }
}
