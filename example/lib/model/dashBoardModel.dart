class DashBoardModel {
  int userId;
  String email;
  int totalSteps;
  double distance;
  int calories;
  int overAllSteps;
  List<BadgeInfoList> badgeInfoList;
  List<int> stepsUpdatedDate;
  List<dynamic> userJoinSessionId;
  List<ChallengeDetails> challengeDetails;

  DashBoardModel(
      {this.userId,
      this.email,
      this.totalSteps,
      this.distance,
      this.calories,
      this.overAllSteps,
      this.badgeInfoList,
      this.stepsUpdatedDate,
      this.userJoinSessionId,
      this.challengeDetails});

  DashBoardModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    totalSteps = json['totalSteps'];
    distance = json['distance'];
    calories = json['calories'];
    overAllSteps = json['overAllSteps'];
    if (json['badgeInfoList'] != null) {
      badgeInfoList = new List<BadgeInfoList>();
      json['badgeInfoList'].forEach((v) {
        badgeInfoList.add(new BadgeInfoList.fromJson(v));
      });
    }
    stepsUpdatedDate = json['stepsUpdatedDate'].cast<int>();
    userJoinSessionId = json['userJoinSessionId'];
    if (json['challengeDetails'] != null) {
      challengeDetails = new List<ChallengeDetails>();
      json['challengeDetails'].forEach((v) {
        challengeDetails.add(new ChallengeDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['email'] = this.email;
    data['totalSteps'] = this.totalSteps;
    data['distance'] = this.distance;
    data['calories'] = this.calories;
    data['overAllSteps'] = this.overAllSteps;
    if (this.badgeInfoList != null) {
      data['badgeInfoList'] =
          this.badgeInfoList.map((v) => v.toJson()).toList();
    }
    data['stepsUpdatedDate'] = this.stepsUpdatedDate;
    data['userJoinSessionId'] = this.userJoinSessionId;
    if (this.challengeDetails != null) {
      data['challengeDetails'] =
          this.challengeDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BadgeInfoList {
  int distance;
  int numberOfBadges;

  BadgeInfoList({this.distance, this.numberOfBadges});

  BadgeInfoList.fromJson(Map<String, dynamic> json) {
    distance = json['distance'];
    numberOfBadges = json['numberOfBadges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distance'] = this.distance;
    data['numberOfBadges'] = this.numberOfBadges;
    return data;
  }
}

class ChallengeDetails {
  String challengeId;
  String challengeName;
  int challengeScore;

  ChallengeDetails({this.challengeId, this.challengeName, this.challengeScore});

  ChallengeDetails.fromJson(Map<String, dynamic> json) {
    challengeId = json['challengeId'];
    challengeName = json['challengeName'];
    challengeScore = json['challengeScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['challengeId'] = this.challengeId;
    data['challengeName'] = this.challengeName;
    data['challengeScore'] = this.challengeScore;
    return data;
  }
}
