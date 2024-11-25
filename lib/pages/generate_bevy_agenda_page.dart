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
  final _displayNameId = TextEditingController(
    text: '84057',
  );

  String? content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Generate Bevy Agenda JSON'),
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
            Center(
              child: TextButton(
                onPressed: _fetch,
                child: const Text('Fetch'),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Text('Bevy Agenda JSON'),
                const SizedBox(width: 8.0),
                TextButton.icon(
                  onPressed: content == null
                      ? null
                      : () {
                          Clipboard.setData(
                            ClipboardData(text: content!),
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
                    child: SelectableText(content ?? ''),
                  ),
                ),
              ),
            ),
          ],
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
      content = jsonEncode(entity.toJson());
    });
  }
}
