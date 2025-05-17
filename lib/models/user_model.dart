class UserModel {
  String? id;
  String? name;
  String? img;
  int? daysToRefill;
  int? itemsAttention;
  List<dynamic>? monitorUsers;
  String? createdAt;
  String? modifiedAt;

  UserModel({
    this.id,
    this.name,
    this.img,
    this.daysToRefill,
    this.itemsAttention,
    this.createdAt,
    this.modifiedAt,
    this.monitorUsers,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map["id"] as String,
      name: map["name"] as String,
      img: map["img"] != null ? map["img"] as String : null,
      daysToRefill: map["days_to_refill"] as int,
      itemsAttention: map["items_attention"] as int,
      monitorUsers: map["monitor_users"] as List<dynamic>,
      createdAt: map["created_at"],
      modifiedAt: map["modified_at"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "img": img,
      "days_to_refill": daysToRefill,
      "items_attention": itemsAttention,
      "monitor_users": []
    };
  }
}
