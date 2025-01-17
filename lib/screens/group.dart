class Group {
  final int id;
  final String title;
  final String description;
  final String imageUrl;

  Group({required this.id, required this.title, required this.description, required this.imageUrl});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
}
