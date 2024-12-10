import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdg_platform_tool/api/gdg/models/agenda_entity.dart';
import 'package:gdg_platform_tool/api/sessionize/models/shedule_grid_entity.dart';
import 'package:gdg_platform_tool/api/sessionize/models/speaker_entity.dart';
import 'package:gdg_platform_tool/api/sessionize/sessionize_api.dart';
import 'package:intl/intl.dart';

class GenerateBevyAgendaPage extends StatefulWidget {
  const GenerateBevyAgendaPage({
    super.key,
  });

  @override
  State<GenerateBevyAgendaPage> createState() => _GenerateBevyAgendaPageState();
}

class _GenerateBevyAgendaPageState extends State<GenerateBevyAgendaPage> {
  final _apiId = TextEditingController();
  final _displayNameId = TextEditingController(
    text: '84050',
  );
  final _sessionTypeId = TextEditingController(
    text: '84044',
  );
  final _sessionLanguageId = TextEditingController(
    text: '84043',
  );
  final _sessionTagId = TextEditingController(
    text: '84049',
  );

  String? bevyContent;
  String? oPassContent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Generate Sessionize Agenda JSON'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32.0,
          vertical: 16.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _apiId,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(),
                labelText: 'Sessionize API ID',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _displayNameId,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(),
                labelText: 'Sessionize DisplayName ID',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _sessionTypeId,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(),
                labelText: 'Sessionize Session Type ID',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _sessionLanguageId,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(),
                labelText: 'Sessionize Session Language ID',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _sessionTagId,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(),
                labelText: 'Sessionize Session Tag ID',
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: TextButton(
                onPressed: _fetch,
                child: const Text('Fetch'),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text('Bevy Agenda JSON'),
                            const SizedBox(width: 8.0),
                            TextButton.icon(
                              onPressed: bevyContent == null
                                  ? null
                                  : () {
                                      Clipboard.setData(
                                        ClipboardData(text: bevyContent!),
                                      );
                                    },
                              icon: const Icon(Icons.copy),
                              label: const Text('Copy'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SelectableText(bevyContent ?? ''),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text('OPass Agenda JSON'),
                            const SizedBox(width: 8.0),
                            TextButton.icon(
                              onPressed: oPassContent == null
                                  ? null
                                  : () {
                                      Clipboard.setData(
                                        ClipboardData(text: oPassContent!),
                                      );
                                    },
                              icon: const Icon(Icons.copy),
                              label: const Text('Copy'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SelectableText(oPassContent ?? ''),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _fetch() async {
    final id = _apiId.text;
    final api = SessionizeApi(id: id);
    final scheduleList = await api.getScheduleGrid();
    final speakerList = await api.getSpeakerList();
    _generateBevyJson(scheduleList, speakerList);
    _generateOpassJson(scheduleList, speakerList);
  }

  Future<void> _generateBevyJson(
    List<ScheduleGridEntity> scheduleList,
    List<SpeakerEntity> speakerList,
  ) async {
    log(scheduleList.first.toJson().toString());
    final entity = AgendaEntity(
      multiday: false,
      anyDescriptions: false,
      empty: false,
      days: [],
    );
    final s = scheduleList.first;
    final format = DateFormat('h:mm a');
    for (var room in s.rooms ?? <Rooms>[]) {
      final day = AgendaDayEntity(
        title: room.name ?? '',
        agenda: [
          for (var session in room.sessions ?? <Sessions>[])
            GdgSessionEntiy(
              activity: '${session.title} - ${session.speakers?.map(
                (e) {
                  final s = speakerList
                      .where((element) => element.id == e.id)
                      .firstOrNull;
                  final title = s?.questionAnswers
                      ?.where(
                        (element) =>
                            element.id == int.parse(_displayNameId.text),
                      )
                      .firstOrNull
                      ?.answer;
                  return title ?? e.name;
                },
              ).join('、')}',
              description: '${session.description ?? ''}',
              time: format.format(
                DateTime.parse(session.startsAt!),
              ),
              audienceType: "IN_PERSON",
            ),
        ],
      );
      entity.days.add(day);
    }
    setState(() {
      bevyContent = jsonEncode(entity.toJson());
    });
  }

  Future<void> _generateOpassJson(
    List<ScheduleGridEntity> scheduleList,
    List<SpeakerEntity> speakerList,
  ) async {
    final sessionTypeId = int.parse(_sessionTypeId.text);
    final sessionLanguageId = int.parse(_sessionLanguageId.text);
    final sessionTagId = int.parse(_sessionTagId.text);
    final json = {
      'rooms': [],
      'session_types': [],
      'sessions': [],
      'speakers': [],
      'tags': [],
    };
    final types = <String, Map<String, dynamic>>{};
    final tags = <String, Map<String, dynamic>>{};
    final s = scheduleList.first;
    final format = DateFormat('yyyy-MM-ddTHH:mm:ss');
    for (var room in s.rooms ?? <Rooms>[]) {
      if (room.id case var id?) {
        json['rooms']?.add({
          "id": id.toString(),
          "en": {"name": room.name},
          "zh": {"name": room.name}
        });
      }
      for (var session in room.sessions ?? <Sessions>[]) {
        final sessionTags = session.categories
            ?.where((e) => e.id == sessionTagId)
            .firstOrNull
            ?.categoryItems;
        final sessionTypes = session.categories
            ?.where((e) => e.id == sessionTypeId)
            .firstOrNull
            ?.categoryItems;
        if (sessionTags case var sessionTags?) {
          for (final tag in sessionTags) {
            if (!tags.containsKey(tag.id)) {
              tags['${tag.id}'] = {
                "id": "${tag.id}",
                "en": {"name": "${tag.name}"},
                "zh": {"name": "${tag.name}"}
              };
            }
          }
        }
        if (sessionTypes case var sessionTypes?) {
          for (final type in sessionTypes) {
            if (!types.containsKey(type.id)) {
              types['${type.id}'] = {
                "id": "${type.id}",
                "en": {"name": "${type.name}"},
                "zh": {
                  "name": _sessionTypeMapping["${type.name}"] ?? "${type.name}"
                }
              };
            }
          }
        }
        json['sessions']?.add({
          "id": session.id,
          "start": "${format.format(DateTime.parse(session.startsAt!))}+08:00",
          "end": "${format.format(DateTime.parse(session.endsAt!))}+08:00",
          "language": session.categories
                  ?.where((e) => e.id == sessionLanguageId)
                  .firstOrNull
                  ?.categoryItems
                  ?.firstOrNull
                  ?.name ??
              '中文',
          "room": room.id.toString(),
          "speakers": session.speakers?.map((e) => e.id).toList(),
          "tags": session.categories
                  ?.where((e) => e.id == sessionTagId)
                  .firstOrNull
                  ?.categoryItems
                  ?.map((e) => '${e.id}')
                  .toList() ??
              [],
          "type": session.categories
                  ?.where((e) => e.id == sessionTypeId)
                  .firstOrNull
                  ?.categoryItems
                  ?.firstOrNull
                  ?.id ??
              '297889',
          "en": {
            "description": '${session.description ?? '  '}',
            "title": session.title,
          },
          "zh": {
            "description": '${session.description ?? '  '}',
            "title": session.title,
          }
        });
      }
    }
    for (final speaker in speakerList) {
      if (speaker.id case var id?) {
        final data = {
          "bio": speaker.bio ?? '',
          "name": speaker.questionAnswers
                  ?.where(
                    (element) => element.id == int.parse(_displayNameId.text),
                  )
                  .firstOrNull
                  ?.answer ??
              '',
        };
        json['speakers']?.add({
          "id": id,
          "avatar": speaker.profilePicture ?? '',
          "en": data,
          "zh": data,
        });
      }
    }
    json['tags'] = tags.values.toList();
    json['session_types'] = types.values.toList();
    setState(() {
      oPassContent = jsonEncode(json);
    });
  }
}

const _sessionTypeMapping = {
  'Session': '一般議程',
  'Short Talk': '短講',
  'Workshop': '工作坊'
};
