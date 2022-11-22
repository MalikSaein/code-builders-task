class MemeModel {
  MemeModel({
    this.id,
    this.name,
    this.url,
    this.width,
    this.height,
    this.boxCount,
  });

  dynamic id;
  String? name;
  String? url;
  dynamic width;
  dynamic height;
  dynamic boxCount;

  factory MemeModel.fromJson(Map<String, dynamic> json) => MemeModel(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] ?? '',
    url: json["url"] == null ? null : json["url"],
    width: json["width"] == null ? null : json["width"],
    height: json["height"] == null ? null : json["height"],
    boxCount: json["box_count"] == null ? null : json["box_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id.toString(),
    "name": name == null ? null : name,
    "url": url == null ? null : url,
    "width": width == null ? null : width.toString(),
    "height": height == null ? null : height.toString(),
    "box_count": boxCount == null ? null : boxCount.toString(),
  };
}
