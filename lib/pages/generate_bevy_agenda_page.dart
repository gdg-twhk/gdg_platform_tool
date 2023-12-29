import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdg_platform_tool/api/gdg/models/agenda_entity.dart';
import 'package:gdg_platform_tool/api/sessionize/models/shedule_grid_entity.dart';
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

  String? content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Generate Bevy Agenda JSON'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _apiId,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: _fetch,
                    child: const Text('Fetch'),
                  ),
                  const SizedBox(width: 8.0),
                  TextButton(
                    onPressed: content == null
                        ? null
                        : () {
                            Clipboard.setData(
                              ClipboardData(text: content!),
                            );
                          },
                    child: const Text('Copy'),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Text(content ?? ''),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _fetch() async {
    final id = _apiId.text;
    final api = SessionizeApi(id: id);
    final list = await api.getScheduleGrid();
    final speakerList = await api.getSpeakerList();
    log(list.first.toJson().toString());
    final entity = AgendaEntity(
      multiday: false,
      anyDescriptions: false,
      empty: false,
      days: [],
    );
    final s = list.first;
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
                      ?.where((element) => element.id == 60915)
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
      content = jsonEncode(entity.toJson());
    });
  }
}
