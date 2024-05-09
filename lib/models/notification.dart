class Notifications {
  int? id;
  String? type;
  int? userId;
  AssignmentContact? assignmentContact;
  Interested_contact? interested_contact;
  String? createdAt;
  String? updatedAt;

  Notifications({
    this.id,
    this.type,
    this.userId,
    this.assignmentContact,
    this.createdAt,
    this.updatedAt,
  });

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    userId = json['user_id'];
    assignmentContact = json['assignment_contact'] != null
        ? AssignmentContact.fromJson(json['assignment_contact'])
        : null;
    interested_contact = json['intere_contac'] != null
        ? Interested_contact.fromJson(json['intere_contac'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Interested_contact{
  int? id;
  String? fullName;
  String? phone;
  Interested_contact({
    this.id,
    this.fullName,
    this.phone,
  });
  Interested_contact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    phone = json['phone'];
}

}


class AssignmentContact {
  int? id;
  Interested? interested;
  int? userId;
  String? createdAt;
  String? updatedAt;

  AssignmentContact({
    this.id,
    this.interested,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  AssignmentContact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    interested = json['interested'] != null
        ? Interested.fromJson(json['interested'])
        : null;
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Interested {
  int? id;
  String? fullName;
  String? phone;
  String? email;
  String? createdAt;
  String? updatedAt;

  Interested({
    this.id,
    this.fullName,
    this.phone,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  Interested.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    phone = json['phone'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}