class AllImagesModel {
  String activityId;
  String fileName;
  String uploadDate;
  List<int> createdDateTime;
  String createdBy;

  AllImagesModel(
      {this.activityId,
      this.fileName,
      this.uploadDate,
      this.createdDateTime,
      this.createdBy});

  AllImagesModel.fromJson(Map<String, dynamic> json) {
    activityId = json['activityId'];
    fileName = json['fileName'];
    uploadDate = json['uploadDate'];
    createdDateTime = json['createdDateTime'].cast<int>();
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activityId'] = this.activityId;
    data['fileName'] = this.fileName;
    data['uploadDate'] = this.uploadDate;
    data['createdDateTime'] = this.createdDateTime;
    data['createdBy'] = this.createdBy;
    return data;
  }
}
