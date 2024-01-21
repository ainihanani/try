class Quiz {
  Quiz({
    required this.title,
    required this.description,
    required this.images,
  });

  final String title;
  final String description;
  final String images;

  Quiz.fromJson(Map<String, Object?> json)
      : this(
    title: json['title']! as String,
    description: json['description']! as String,
    images: json['imagePath']! as String,
  );

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'description': description,
      'imagePath': images,
    };
  }


}
