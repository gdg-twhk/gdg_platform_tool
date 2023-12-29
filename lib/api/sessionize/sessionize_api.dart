import 'dart:convert';

import 'package:gdg_platform_tool/api/sessionize/models/shedule_grid_entity.dart';
import 'package:gdg_platform_tool/api/sessionize/models/speaker_entity.dart';
import 'package:http/http.dart';

class SessionizeApi {
  String host = 'sessionize.com';

  final String id;

  SessionizeApi({
    required this.id,
  });

  Future<List<ScheduleGridEntity>> getScheduleGrid() async {
    final response = await get(
      Uri.https(host, '/api/v2/$id/view/GridSmart'),
    );
    final json = jsonDecode(response.body);
    final list = (json as List<dynamic>)
        .map(
          (json) => ScheduleGridEntity.fromJson(json),
        )
        .toList();
    return list;
  }

  Future<List<SpeakerEntity>> getSpeakerList() async {
    final response = await get(
      Uri.https(host, '/api/v2/$id/view/Speakers'),
    );
    final json = jsonDecode(response.body);
    final list = (json as List<dynamic>)
        .map(
          (json) => SpeakerEntity.fromJson(json),
        )
        .toList();
    return list;
  }
}
