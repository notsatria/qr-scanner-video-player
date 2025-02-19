class VideoResult {
  final int? id;
  final String title;
  final String? description;
  final String url;

  const VideoResult(
      {this.id, required this.title, required this.url, this.description});

  Map<String, Object?> toMap() {
    return {'id': id, 'title': title, 'description': description, 'url': url};
  }

  factory VideoResult.fromMap(Map<String, dynamic> map) {
    return VideoResult(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        url: map['url']);
  }

  @override
  String toString() {
    return 'VideoResult{id: $id, title: $title, url: $url}';
  }
}
