class PackageDetailModel {
  List<String> duration;
  List<String> package;

  PackageDetailModel({
    this.duration = const <String>[],
    this.package = const <String>[],
  });

  factory PackageDetailModel.fromMap(Map<String, dynamic> json) =>
      PackageDetailModel(
        duration: json["duration"] == null
            ? <String>[]
            : List<String>.from(json["duration"]!.map((x) => x)),
        package: json["package"] == null
            ? <String>[]
            : List<String>.from(json["package"]!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        "duration": List<dynamic>.from(duration.map((String x) => x)),
        "package": List<dynamic>.from(package.map((String x) => x)),
      };
}
