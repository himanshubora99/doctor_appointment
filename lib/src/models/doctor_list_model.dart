class DoctorDetailsModel {
  String doctorName;
  String image;
  String speciality;
  String location;
  int patientsServed;
  int yearsOfExperience;
  double rating;
  int numberOfReviews;
  Map<String, List<String>>? availability;

  DoctorDetailsModel({
    this.doctorName = '',
    this.image = '',
    this.speciality = '',
    this.location = '',
    this.patientsServed = 0,
    this.yearsOfExperience = 0,
    this.rating = 0,
    this.numberOfReviews = 0,
    this.availability,
  });

  factory DoctorDetailsModel.fromMap(Map<String, dynamic> json) =>
      DoctorDetailsModel(
        doctorName: json["doctor_name"] ?? '',
        image: json["image"] ?? '',
        speciality: json["speciality"] ?? '',
        location: json["location"] ?? '',
        patientsServed: json["patients_served"] ?? 0,
        yearsOfExperience: json["years_of_experience"] ?? 0,
        rating: json["rating"]?.toDouble() ?? 0,
        numberOfReviews: json["number_of_reviews"] ?? 0,
        availability: Map.from(json["availability"]!).map((k, v) =>
            MapEntry<String, List<String>>(
                k, List<String>.from(v.map((x) => x)))),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        "doctor_name": doctorName,
        "image": image,
        "speciality": speciality,
        "location": location,
        "patients_served": patientsServed,
        "years_of_experience": yearsOfExperience,
        "rating": rating,
        "number_of_reviews": numberOfReviews,
        "availability": Map.from(availability!).map((k, v) =>
            MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
      };
}
