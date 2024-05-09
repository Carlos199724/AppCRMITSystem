class UserList {
  int? id;
  String? fullName;
  String? companyName;
  String? occupation;
  String? email;
  String? phone;
  Status? status;
  bool? useSap;
  SubStatus? subStatus;
  String? originCourse;
  String? nroDocument;
  String? assignmentDate;
  

  UserList(
      {this.id,
      this.fullName,
      this.companyName,
      this.occupation,
      this.email,
      this.phone,
      this.status,
      this.useSap,
      this.subStatus,
      this.originCourse,
      this.nroDocument,
      this.assignmentDate});

  UserList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    companyName = json['company_name'];
    occupation = json['occupation'];
    email = json['email'];
    phone = json['phone'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    useSap = json['use_sap'];
    subStatus = json['sub_status'] != null
        ? new SubStatus.fromJson(json['sub_status'])
        : null;
    originCourse = json['origin_course'];
    nroDocument = json['nro_document'];
    assignmentDate = json['assignment_date'];
  }

  get data => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['company_name'] = this.companyName;
    data['occupation'] = this.occupation;
    data['email'] = this.email;
    data['phone'] = this.phone;
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    data['use_sap'] = this.useSap;
    if (this.subStatus != null) {
      data['sub_status'] = this.subStatus!.toJson();
    }
    data['origin_course'] = this.originCourse;
    data['nro_document'] = this.nroDocument;
    data['assignment_date'] = this.assignmentDate;
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