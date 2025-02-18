class VideoResult {
  final int? id;
  final String title;
  final String url;

  const VideoResult({this.id, required this.title, required this.url});

  Map<String, Object?> toMap() {
    return {'id': id, 'title': title, 'url': url};
  }

  factory VideoResult.fromMap(Map<String, dynamic> map) {
    return VideoResult(id: map['id'], title: map['title'], url: map['url']);
  }

  @override
  String toString() {
    return 'VideoResult{id: $id, title: $title, url: $url}';
  }
}
