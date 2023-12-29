class AgendaEntity {
  AgendaEntity({
    required this.multiday,
    required this.anyDescriptions,
    required this.empty,
    required this.days,
  });

  bool multiday;
  bool anyDescriptions;
  bool empty;
  List<AgendaDayEntity> days;

  AgendaEntity copyWith({
    bool? multiday,
    bool? anyDescriptions,
    bool? empty,
    List<AgendaDayEntity>? days,
  }) =>
      AgendaEntity(
        multiday: multiday ?? this.multiday,
        anyDescriptions: anyDescriptions ?? this.anyDescriptions,
        empty: empty ?? this.empty,
        days: days ?? this.days,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['multiday'] = multiday;
    map['any_descriptions'] = anyDescriptions;
    map['empty'] = empty;
    map['days'] = days.map((v) => v.toJson()).toList();
    return map;
  }
}

class AgendaDayEntity {
  AgendaDayEntity({
    this.title,
    this.agenda,
  });

  AgendaDayEntity.fromJson(dynamic json) {
    title = json['title'];
    if (json['agenda'] != null) {
      agenda = [];
      json['agenda'].forEach((v) {
        agenda?.add(GdgSessionEntiy.fromJson(v));
      });
    }
  }

  String? title;
  List<GdgSessionEntiy>? agenda;

  AgendaDayEntity copyWith({
    String? title,
    List<GdgSessionEntiy>? agenda,
  }) =>
      AgendaDayEntity(
        title: title ?? this.title,
        agenda: agenda ?? this.agenda,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    if (agenda != null) {
      map['agenda'] = agenda?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class GdgSessionEntiy {
  GdgSessionEntiy({
    this.time,
    this.activity,
    this.description,
    this.audienceType,
  });

  GdgSessionEntiy.fromJson(dynamic json) {
    time = json['time'];
    activity = json['activity'];
    description = json['description'];
    audienceType = json['audience_type'];
  }

  String? time;
  String? activity;
  String? description;
  String? audienceType;

  GdgSessionEntiy copyWith({
    String? time,
    String? activity,
    String? description,
    String? audienceType,
  }) =>
      GdgSessionEntiy(
        time: time ?? this.time,
        activity: activity ?? this.activity,
        description: description ?? this.description,
        audienceType: audienceType ?? this.audienceType,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = time;
    map['activity'] = activity;
    map['description'] = description;
    map['audience_type'] = audienceType;
    return map;
  }
}
