class Cat {
  final String apiId;
  final String url;
  final List<dynamic> tags;
  String name;

  Cat({
    required this.apiId,
    required this.tags,
    required this.url,
    this.name = '',
  });

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      apiId: json['apiId'],
      url: json['url'],
      tags: json['tags'],
      name: '',
    );
  }

  Map<String, dynamic> toMap() {
    var tagsString = tags.join(',');

    return {'apiId': apiId, 'url': url, 'tags': tagsString, 'name': name};
  }

  @override
  String toString() {
    return 'Cat{id: $apiId, url: $url, tags: $tags, name: $name}';
  }
}
