class UserDetalle {
  int? id;
  String? fullName;
  String? companyName;
  String? occupation;
  String? mediumContact;
  String? email;
  String? phone;
  Status? status;
  SubStatus? subStatus;
  bool? useSap;
  String? originCourse;
  String? nroDocument;
  String? createdAt;

  UserDetalle(
      {this.id,
      this.fullName,
      this.companyName,
      this.occupation,
      this.mediumContact,
      this.email,
      this.phone,
      this.status,
      this.subStatus,
      this.useSap,
      this.originCourse,
      this.nroDocument,
      this.createdAt});

  UserDetalle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    companyName = json['company_name'];
    occupation = json['occupation'];
    mediumContact = json['medium_contact'];
    email = json['email'];
    phone = json['phone'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    subStatus = json['sub_status'] != null
        ? new SubStatus.fromJson(json['sub_status'])
        : null;
    useSap = json['use_sap'];
    originCourse = json['origin_course'];
    nroDocument = json['nro_document'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['company_name'] = this.companyName;
    data['occupation'] = this.occupation;
    data['medium_contact'] = this.mediumContact;
    data['email'] = this.email;
    data['phone'] = this.phone;
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    if (this.subStatus != null) {
      data['sub_status'] = this.subStatus!.toJson();
    }
    data['use_sap'] = this.useSap;
    data['origin_course'] = this.originCourse;
    data['nro_document'] = this.nroDocument;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Status {
  int? id;
  String? statusName;
  String? createdAt;
  String? updatedAt;

  Status({this.id, this.statusName, this.createdAt, this.updatedAt});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    statusName = json['status_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status_name'] = this.statusName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class SubStatus {
  int? id;
  String? nameSubstatus;
  String? createdAt;
  String? updatedAt;
  int? status;

  SubStatus(
      {this.id,
      this.nameSubstatus,
      this.createdAt,
      this.updatedAt,
      this.status});

  SubStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameSubstatus = json['name_substatus'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_substatus'] = this.nameSubstatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    return data;
  }
}