class dashboardUser {
  int? userId;
  StatusFrequency? statusFrequency;
  SubstatusFrequency? substatusFrequency;
  int? totalStatus;
  int? totalSubstatus;

  dashboardUser(
      {this.userId,
      this.statusFrequency,
      this.substatusFrequency,
      this.totalStatus,
      this.totalSubstatus});

  dashboardUser.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    statusFrequency = json['status_frequency'] != null
        ? new StatusFrequency.fromJson(json['status_frequency'])
        : null;
    substatusFrequency = json['substatus_frequency'] != null
        ? new SubstatusFrequency.fromJson(json['substatus_frequency'])
        : null;
    totalStatus = json['total_status'];
    totalSubstatus = json['total_substatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    if (this.statusFrequency != null) {
      data['status_frequency'] = this.statusFrequency!.toJson();
    }
    if (this.substatusFrequency != null) {
      data['substatus_frequency'] = this.substatusFrequency!.toJson();
    }
    data['total_status'] = this.totalStatus;
    data['total_substatus'] = this.totalSubstatus;
    return data;
  }
}

class StatusFrequency {
  int? nuevo;
  int? reasignado;
  int? pagara;
  int? pagado;
  int? enseguimiento;
  int? caidocalificado;

  StatusFrequency({this.nuevo, this.reasignado,this.pagara,this.pagado,this.enseguimiento, this.caidocalificado});

  StatusFrequency.fromJson(Map<String, dynamic> json) {
    nuevo = json['nuevo'];
    reasignado = json['reasignado'];
    pagara = json['pagara'];
    pagado = json['pagado'];
    enseguimiento = json['enseguimiento'];
    caidocalificado = json['caidocalificado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nuevo'] = this.nuevo;
    data['reasignado'] = this.reasignado;
    data['pagara'] = this.pagara;
    data['pagado'] = this.pagado;
    data['enseguimiento'] = this.enseguimiento;
    data['caidocalificado'] = this.caidocalificado;
    return data;
  }
}

class SubstatusFrequency {
  int? porLlamar;
  int? confirmar;

  SubstatusFrequency({this.porLlamar, this.confirmar,});

  SubstatusFrequency.fromJson(Map<String, dynamic> json) {
    porLlamar = json['por llamar'];
    confirmar = json['confirmara'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['por llamar'] = this.porLlamar;
    data['confirmara'] = this.confirmar;
    return data;
  }
}