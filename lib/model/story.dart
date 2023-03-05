class Story {
  String id;
  String name;
  String description;
  String photoUrl;
  String createdAt;
  double? lat;
  double? lon;

  Story(
      {required this.id,
      required this.name,
      required this.description,
      required this.photoUrl,
      required this.createdAt,
      this.lat,
      this.lon});

  factory Story.fromJson(Map<String, dynamic> json) => Story(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        photoUrl: json['photoUrl'],
        createdAt: json['createdAt'],
        lat: json['lat'],
        lon: json['lon'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'photoUrl': photoUrl,
        'createdAt': createdAt,
        'lat': lat,
        'lon': lon,
      };
}
