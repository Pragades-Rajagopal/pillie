import 'package:pillie_app/utils/helper_functions.dart';

class PillModel {
  String? id;
  String? name;
  String? brand;
  int? count;
  bool? day;
  bool? noon;
  bool? night;
  int? dosage;
  String? userId;
  String? createdAt;
  String? modifiedAt;

  PillModel({
    this.id,
    this.name,
    this.brand,
    this.count,
    this.day,
    this.noon,
    this.night,
    this.dosage,
    this.userId,
    this.createdAt,
    this.modifiedAt,
  });

  factory PillModel.fromMap(Map<String, dynamic> map) {
    return PillModel(
      id: map["id"] as String,
      name: map["name"] as String,
      brand: map["brand"] as String,
      userId: map["user_id"] as String,
      count: sanitizeValue<dynamic>(map["count"]),
      day: map["day"] as bool,
      noon: map["noon"] as bool,
      night: map["night"] as bool,
      dosage: sanitizeValue<dynamic>(map["dosage"]),
      createdAt: map["created_at"],
      modifiedAt: map["modified_at"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "brand": brand,
      "count": count,
      "user_id": userId,
      "day": day,
      "noon": noon,
      "night": night,
      "dosage": dosage,
    };
  }
}
