class SpeakerEntity {
  SpeakerEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.bio,
    this.tagLine,
    this.profilePicture,
    this.isTopSpeaker,
    this.questionAnswers,
    this.categories,
  });

  SpeakerEntity.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    bio = json['bio'];
    tagLine = json['tagLine'];
    profilePicture = json['profilePicture'];
    isTopSpeaker = json['isTopSpeaker'];
    if (json['questionAnswers'] != null) {
      questionAnswers = [];
      json['questionAnswers'].forEach((v) {
        questionAnswers?.add(QuestionAnswers.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
  }

  String? id;
  String? firstName;
  String? lastName;
  String? fullName;
  String? bio;
  String? tagLine;
  String? profilePicture;
  bool? isTopSpeaker;
  List<dynamic>? links;
  List<QuestionAnswers>? questionAnswers;
  List<Categories>? categories;

  SpeakerEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? fullName,
    String? bio,
    String? tagLine,
    String? profilePicture,
    bool? isTopSpeaker,
    List<dynamic>? links,
    List<QuestionAnswers>? questionAnswers,
    List<Categories>? categories,
  }) =>
      SpeakerEntity(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        fullName: fullName ?? this.fullName,
        bio: bio ?? this.bio,
        tagLine: tagLine ?? this.tagLine,
        profilePicture: profilePicture ?? this.profilePicture,
        isTopSpeaker: isTopSpeaker ?? this.isTopSpeaker,
        questionAnswers: questionAnswers ?? this.questionAnswers,
        categories: categories ?? this.categories,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['fullName'] = fullName;
    map['bio'] = bio;
    map['tagLine'] = tagLine;
    map['profilePicture'] = profilePicture;
    map['isTopSpeaker'] = isTopSpeaker;
    if (links != null) {
      map['links'] = links?.map((v) => v.toJson()).toList();
    }
    if (questionAnswers != null) {
      map['questionAnswers'] = questionAnswers?.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Categories {
  Categories({
    this.id,
    this.name,
    this.categoryItems,
    this.sort,
  });

  Categories.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    if (json['categoryItems'] != null) {
      categoryItems = [];
      json['categoryItems'].forEach((v) {
        categoryItems?.add(CategoryItems.fromJson(v));
      });
    }
    sort = json['sort'];
  }

  num? id;
  String? name;
  List<CategoryItems>? categoryItems;
  num? sort;

  Categories copyWith({
    num? id,
    String? name,
    List<CategoryItems>? categoryItems,
    num? sort,
  }) =>
      Categories(
        id: id ?? this.id,
        name: name ?? this.name,
        categoryItems: categoryItems ?? this.categoryItems,
        sort: sort ?? this.sort,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    if (categoryItems != null) {
      map['categoryItems'] = categoryItems?.map((v) => v.toJson()).toList();
    }
    map['sort'] = sort;
    return map;
  }
}

class CategoryItems {
  CategoryItems({
    this.id,
    this.name,
  });

  CategoryItems.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  num? id;
  String? name;

  CategoryItems copyWith({
    num? id,
    String? name,
  }) =>
      CategoryItems(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}

class QuestionAnswers {
  QuestionAnswers({
    this.id,
    this.question,
    this.questionType,
    this.answer,
    this.sort,
    this.answerExtra,
  });

  QuestionAnswers.fromJson(dynamic json) {
    id = json['id'];
    question = json['question'];
    questionType = json['questionType'];
    answer = json['answer'];
    sort = json['sort'];
    answerExtra = json['answerExtra'];
  }

  num? id;
  String? question;
  String? questionType;
  String? answer;
  num? sort;
  dynamic answerExtra;

  QuestionAnswers copyWith({
    num? id,
    String? question,
    String? questionType,
    String? answer,
    num? sort,
    dynamic answerExtra,
  }) =>
      QuestionAnswers(
        id: id ?? this.id,
        question: question ?? this.question,
        questionType: questionType ?? this.questionType,
        answer: answer ?? this.answer,
        sort: sort ?? this.sort,
        answerExtra: answerExtra ?? this.answerExtra,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['question'] = question;
    map['questionType'] = questionType;
    map['answer'] = answer;
    map['sort'] = sort;
    map['answerExtra'] = answerExtra;
    return map;
  }
}
