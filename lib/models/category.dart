class Category {
  String thumbnail;
  String name;
  int noOfCourses;

  Category({
    required this.name,
    required this.noOfCourses,
    required this.thumbnail,
  });
}

List<Category> categoryList = [
  Category(
    name: 'Basic Computer Components',
    noOfCourses: 2,
    thumbnail: 'assets/icons/laptop.jpg',
  ),
  Category(
    name: 'ShortcutKey',
    noOfCourses: 1,
    thumbnail: 'assets/icons/design.jpg',
  ),

   Category(
    name: 'Quiz',
    noOfCourses: 1,
    thumbnail: 'assets/icons/accounting.jpg',
  ),

];