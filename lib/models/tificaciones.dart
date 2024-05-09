class Tipificaciones {
  int? id;
  User? user;
  IntereContac? intereContac;
  String? comment;
  String? reminderDate;
  bool? visibleAdmin;
  String? createdAt;
  String? updatedAt;

  Tipificaciones(
      {this.id,
      this.user,
      this.intereContac,
      this.comment,
      this.reminderDate,
      this.visibleAdmin,
      this.createdAt,
      this.updatedAt});

  Tipificaciones.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    intereContac = json['intere_contac'] != null
        ? new IntereContac.fromJson(json['intere_contac'])
        : null;
    comment = json['comment'];
    reminderDate = json['reminder_date'];
    visibleAdmin = json['visible_admin'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.intereContac != null) {
      data['intere_contac'] = this.intereContac!.toJson();
    }
    data['comment'] = this.comment;
    data['reminder_date'] = this.reminderDate;
    data['visible_admin'] = this.visibleAdmin;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? name;
  String? email;
  String? phone;
  bool? userAdmin;

  User(
      {this.id,
      this.username,
      this.name,
      this.email,
      this.phone,
      this.userAdmin});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    userAdmin = json['user_admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['user_admin'] = this.userAdmin;
    return data;
  }
}

class IntereContac {
  int? id;
  String? fullName;
  String? phone;
  String? email;
  String? createdAt;
  String? updatedAt;

  IntereContac(
      {this.id,
      this.fullName,
      this.phone,
      this.email,
      this.createdAt,
      this.updatedAt});

  IntereContac.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    phone = json['phone'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}