class UserDetailsModel {
  int userId;
  String firstName;
  String lastName;
  String email;
  String contact;
  String associateType;
  String employeeId;
  String userStatus;
  String location;
  List<int> createTime;
  List<int> updateTime;
  String updatedBy;
  RoleInfo roleInfo;
  String locale;
  LoginInfo loginInfo;

  UserDetailsModel(
      {this.userId,
      this.firstName,
      this.lastName,
      this.email,
      this.contact,
      this.associateType,
      this.employeeId,
      this.userStatus,
      this.location,
      this.createTime,
      this.updateTime,
      this.updatedBy,
      this.roleInfo,
      this.locale,
      this.loginInfo});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    contact = json['contact'];
    associateType = json['associateType'];
    employeeId = json['employeeId'];
    userStatus = json['userStatus'];
    location = json['location'];
    createTime = json['createTime'].cast<int>();
    updateTime = json['updateTime'].cast<int>();
    updatedBy = json['updatedBy'];
    roleInfo = json['roleInfo'] != String
        ? new RoleInfo.fromJson(json['roleInfo'])
        : String;
    locale = json['locale'];
    loginInfo = json['loginInfo'] != String
        ? new LoginInfo.fromJson(json['loginInfo'])
        : String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['associateType'] = this.associateType;
    data['employeeId'] = this.employeeId;
    data['userStatus'] = this.userStatus;
    data['location'] = this.location;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['updatedBy'] = this.updatedBy;
    if (this.roleInfo != String) {
      data['roleInfo'] = this.roleInfo.toJson();
    }
    data['locale'] = this.locale;
    if (this.loginInfo != String) {
      data['loginInfo'] = this.loginInfo.toJson();
    }
    return data;
  }
}

class RoleInfo {
  String roleId;
  String roleName;
  String roleCode;
  String role;

  RoleInfo({this.roleId, this.roleName, this.roleCode, this.role});

  RoleInfo.fromJson(Map<String, dynamic> json) {
    roleId = json['roleId'];
    roleName = json['roleName'];
    roleCode = json['roleCode'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roleId'] = this.roleId;
    data['roleName'] = this.roleName;
    data['roleCode'] = this.roleCode;
    data['role'] = this.role;
    return data;
  }
}

class LoginInfo {
  String password;
  int loginAttempts;
  String loginAccountStatus;
  String statusReason;
  String pwdChangeReq;
  String lastPwdDate;
  String loginType;
  String lastLoginDate;
  String lastLogoutDate;
  bool consentAccept;
  String consentAcceptedDate;
  String consentDeclineDate;
  bool firstLogin;

  LoginInfo(
      {this.password,
      this.loginAttempts,
      this.loginAccountStatus,
      this.statusReason,
      this.pwdChangeReq,
      this.lastPwdDate,
      this.loginType,
      this.lastLoginDate,
      this.lastLogoutDate,
      this.consentAccept,
      this.consentAcceptedDate,
      this.consentDeclineDate,
      this.firstLogin});

  LoginInfo.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    loginAttempts = json['loginAttempts'];
    loginAccountStatus = json['loginAccountStatus'];
    statusReason = json['statusReason'];
    pwdChangeReq = json['pwdChangeReq'];
    lastPwdDate = json['lastPwdDate'];
    loginType = json['loginType'];
    lastLoginDate = json['lastLoginDate'];
    lastLogoutDate = json['lastLogoutDate'];
    consentAccept = json['consentAccept'];
    consentAcceptedDate = json['consentAcceptedDate'];
    consentDeclineDate = json['consentDeclineDate'];
    firstLogin = json['firstLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['loginAttempts'] = this.loginAttempts;
    data['loginAccountStatus'] = this.loginAccountStatus;
    data['statusReason'] = this.statusReason;
    data['pwdChangeReq'] = this.pwdChangeReq;
    data['lastPwdDate'] = this.lastPwdDate;
    data['loginType'] = this.loginType;
    data['lastLoginDate'] = this.lastLoginDate;
    data['lastLogoutDate'] = this.lastLogoutDate;
    data['consentAccept'] = this.consentAccept;
    data['consentAcceptedDate'] = this.consentAcceptedDate;
    data['consentDeclineDate'] = this.consentDeclineDate;
    data['firstLogin'] = this.firstLogin;
    return data;
  }
}
