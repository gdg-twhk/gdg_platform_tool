class ScheduleGridEntity {
  ScheduleGridEntity({
    this.date,
    this.isDefault,
    this.rooms,
  });

  ScheduleGridEntity.fromJson(dynamic json) {
    date = json['date'];
    isDefault = json['isDefault'];
    if (json['rooms'] != null) {
      rooms = [];
      json['rooms'].forEach((v) {
        rooms?.add(Rooms.fromJson(v));
      });
    }
  }

  String? date;
  bool? isDefault;
  List<Rooms>? rooms;

  ScheduleGridEntity copyWith({
    String? date,
    bool? isDefault,
    List<Rooms>? rooms,
  }) =>
      ScheduleGridEntity(
        date: date ?? this.date,
        isDefault: isDefault ?? this.isDefault,
        rooms: rooms ?? this.rooms,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['isDefault'] = isDefault;
    if (rooms != null) {
      map['rooms'] = rooms?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Rooms {
  Rooms({
    this.id,
    this.name,
    this.sessions,
  });

  Rooms.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    if (json['sessions'] != null) {
      sessions = [];
      json['sessions'].forEach((v) {
        sessions?.add(Sessions.fromJson(v));
      });
    }
  }

  num? id;
  String? name;
  List<Sessions>? sessions;

  Rooms copyWith({
    num? id,
    String? name,
    List<Sessions>? sessions,
  }) =>
      Rooms(
        id: id ?? this.id,
        name: name ?? this.name,
        sessions: sessions ?? this.sessions,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    if (sessions != null) {
      map['sessions'] = sessions?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Session {
  Session({
    this.id,
    this.title,
    this.description,
    this.startsAt,
    this.endsAt,
    this.isServiceSession,
    this.isPlenumSession,
    this.speakers,
    this.categories,
    this.roomId,
    this.room,
    this.liveUrl,
    this.recordingUrl,
    this.status,
    this.isInformed,
    this.isConfirmed,
  });

  Session.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    startsAt = json['startsAt'];
    endsAt = json['endsAt'];
    isServiceSession = json['isServiceSession'];
    isPlenumSession = json['isPlenumSession'];
    if (json['speakers'] != null) {
      speakers = [];
      json['speakers'].forEach((v) {
        speakers?.add(Speakers.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
    roomId = json['roomId'];
    room = json['room'];
    liveUrl = json['liveUrl'];
    recordingUrl = json['recordingUrl'];
    status = json['status'];
    isInformed = json['isInformed'];
    isConfirmed = json['isConfirmed'];
  }

  String? id;
  String? title;
  dynamic description;
  String? startsAt;
  String? endsAt;
  bool? isServiceSession;
  bool? isPlenumSession;
  List<Speakers>? speakers;
  List<Categories>? categories;
  num? roomId;
  String? room;
  dynamic liveUrl;
  dynamic recordingUrl;
  String? status;
  bool? isInformed;
  bool? isConfirmed;

  Session copyWith({
    String? id,
    String? title,
    dynamic description,
    String? startsAt,
    String? endsAt,
    bool? isServiceSession,
    bool? isPlenumSession,
    List<Speakers>? speakers,
    List<Categories>? categories,
    num? roomId,
    String? room,
    dynamic liveUrl,
    dynamic recordingUrl,
    String? status,
    bool? isInformed,
    bool? isConfirmed,
  }) =>
      Session(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        startsAt: startsAt ?? this.startsAt,
        endsAt: endsAt ?? this.endsAt,
        isServiceSession: isServiceSession ?? this.isServiceSession,
        isPlenumSession: isPlenumSession ?? this.isPlenumSession,
        speakers: speakers ?? this.speakers,
        categories: categories ?? this.categories,
        roomId: roomId ?? this.roomId,
        room: room ?? this.room,
        liveUrl: liveUrl ?? this.liveUrl,
        recordingUrl: recordingUrl ?? this.recordingUrl,
        status: status ?? this.status,
        isInformed: isInformed ?? this.isInformed,
        isConfirmed: isConfirmed ?? this.isConfirmed,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['startsAt'] = startsAt;
    map['endsAt'] = endsAt;
    map['isServiceSession'] = isServiceSession;
    map['isPlenumSession'] = isPlenumSession;
    if (speakers != null) {
      map['speakers'] = speakers?.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    map['roomId'] = roomId;
    map['room'] = room;
    map['liveUrl'] = liveUrl;
    map['recordingUrl'] = recordingUrl;
    map['status'] = status;
    map['isInformed'] = isInformed;
    map['isConfirmed'] = isConfirmed;
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

class Speakers {
  Speakers({
    this.id,
    this.name,
  });

  Speakers.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  String? id;
  String? name;

  Speakers copyWith({
    String? id,
    String? name,
  }) =>
      Speakers(
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

class Sessions {
  Sessions({
    this.id,
    this.title,
    this.description,
    this.startsAt,
    this.endsAt,
    this.isServiceSession,
    this.isPlenumSession,
    this.speakers,
    this.categories,
    this.roomId,
    this.room,
    this.liveUrl,
    this.recordingUrl,
    this.status,
    this.isInformed,
    this.isConfirmed,
  });

  Sessions.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    startsAt = json['startsAt'];
    endsAt = json['endsAt'];
    isServiceSession = json['isServiceSession'];
    isPlenumSession = json['isPlenumSession'];
    if (json['speakers'] != null) {
      speakers = [];
      json['speakers'].forEach((v) {
        speakers?.add(Speakers.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
    roomId = json['roomId'];
    room = json['room'];
    liveUrl = json['liveUrl'];
    recordingUrl = json['recordingUrl'];
    status = json['status'];
    isInformed = json['isInformed'];
    isConfirmed = json['isConfirmed'];
  }

  String? id;
  String? title;
  dynamic description;
  String? startsAt;
  String? endsAt;
  bool? isServiceSession;
  bool? isPlenumSession;
  List<Speakers>? speakers;
  List<Categories>? categories;
  num? roomId;
  String? room;
  dynamic liveUrl;
  dynamic recordingUrl;
  String? status;
  bool? isInformed;
  bool? isConfirmed;

  Sessions copyWith({
    String? id,
    String? title,
    dynamic description,
    String? startsAt,
    String? endsAt,
    bool? isServiceSession,
    bool? isPlenumSession,
    List<Speakers>? speakers,
    List<Categories>? categories,
    num? roomId,
    String? room,
    dynamic liveUrl,
    dynamic recordingUrl,
    String? status,
    bool? isInformed,
    bool? isConfirmed,
  }) =>
      Sessions(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        startsAt: startsAt ?? this.startsAt,
        endsAt: endsAt ?? this.endsAt,
        isServiceSession: isServiceSession ?? this.isServiceSession,
        isPlenumSession: isPlenumSession ?? this.isPlenumSession,
        speakers: speakers ?? this.speakers,
        categories: categories ?? this.categories,
        roomId: roomId ?? this.roomId,
        room: room ?? this.room,
        liveUrl: liveUrl ?? this.liveUrl,
        recordingUrl: recordingUrl ?? this.recordingUrl,
        status: status ?? this.status,
        isInformed: isInformed ?? this.isInformed,
        isConfirmed: isConfirmed ?? this.isConfirmed,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['startsAt'] = startsAt;
    map['endsAt'] = endsAt;
    map['isServiceSession'] = isServiceSession;
    map['isPlenumSession'] = isPlenumSession;
    if (speakers != null) {
      map['speakers'] = speakers?.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    map['roomId'] = roomId;
    map['room'] = room;
    map['liveUrl'] = liveUrl;
    map['recordingUrl'] = recordingUrl;
    map['status'] = status;
    map['isInformed'] = isInformed;
    map['isConfirmed'] = isConfirmed;
    return map;
  }
}
