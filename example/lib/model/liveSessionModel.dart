class LiveSessionModel {
  List<AllItems> allItems;

  LiveSessionModel({this.allItems});

  LiveSessionModel.fromJson(Map<String, dynamic> json) {
    if (json['allItems'] != String) {
      allItems = new List<AllItems>();
      json['allItems'].forEach((v) {
        allItems.add(new AllItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allItems != String) {
      data['allItems'] = this.allItems.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllItems {
  String trainingSessionId;
  List<int> trainingSessionDate;
  String trainingSessionDateStr;
  String trainerName;
  List<int> startTime;
  String startTimeStr;
  List<int> endTime;
  String endTimeStr;
  String title;
  String description;
  int totalSize;
  int currentSize;
  int updatedBy;
  List<int> createdDateTime;
  List<int> updatedDateTime;

  AllItems(
      {this.trainingSessionId,
      this.trainingSessionDate,
      this.trainingSessionDateStr,
      this.trainerName,
      this.startTime,
      this.startTimeStr,
      this.endTime,
      this.endTimeStr,
      this.title,
      this.description,
      this.totalSize,
      this.currentSize,
      this.updatedBy,
      this.createdDateTime,
      this.updatedDateTime});

  AllItems.fromJson(Map<String, dynamic> json) {
    trainingSessionId = json['trainingSessionId'];
    trainingSessionDate = json['trainingSessionDate'].cast<int>();
    trainingSessionDateStr = json['trainingSessionDateStr'].toString();
    trainerName = json['trainerName'].toString();
    startTime = json['startTime'].cast<int>();
    startTimeStr = json['startTimeStr'].toString();
    endTime = json['endTime'].cast<int>();
    endTimeStr = json['endTimeStr'].toString();
    title = json['title'];
    description = json['description'];
    totalSize = json['totalSize'];
    currentSize = json['currentSize'];
    updatedBy = json['updatedBy'];
    createdDateTime = json['createdDateTime'].cast<int>();
    updatedDateTime = json['updatedDateTime'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trainingSessionId'] = this.trainingSessionId;
    data['trainingSessionDate'] = this.trainingSessionDate;
    data['trainingSessionDateStr'] = this.trainingSessionDateStr;
    data['trainerName'] = this.trainerName;
    data['startTime'] = this.startTime;
    data['startTimeStr'] = this.startTimeStr;
    data['endTime'] = this.endTime;
    data['endTimeStr'] = this.endTimeStr;
    data['title'] = this.title;
    data['description'] = this.description;
    data['totalSize'] = this.totalSize;
    data['currentSize'] = this.currentSize;
    data['updatedBy'] = this.updatedBy;
    data['createdDateTime'] = this.createdDateTime;
    data['updatedDateTime'] = this.updatedDateTime;
    return data;
  }
}
