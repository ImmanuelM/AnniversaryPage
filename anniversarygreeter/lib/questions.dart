import 'package:flutter/material.dart';

/// The correct answers that unlock the secret message.
final DateTime _correctDate = DateTime(2018, 11, 20);
const String _correctLocationKeyword = 'grace';

/// Shows the "secret question" dialog and returns whether the answers were
/// correct. Resolves to `false` if the user cancels or dismisses the dialog.
Future<bool> questions(BuildContext context) async {
  final dateControl = TextEditingController();
  final description = TextEditingController();
  DateTime? pickedDate;

  final result = await showDialog<bool>(
    context: context,
    builder: (BuildContext dialogContext) {
      String? errorText;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Answer the following Questions'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Enter the date you got married'),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: dateControl,
                    readOnly: true,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_month_rounded),
                      hintText: 'Tap to pick a date',
                    ),
                    onTap: () async {
                      final selected = await showDatePicker(
                        context: context,
                        initialDate: pickedDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2110),
                      );
                      if (selected != null) {
                        setState(() {
                          pickedDate = selected;
                          dateControl.text =
                              '${selected.year}-${selected.month.toString().padLeft(2, '0')}-${selected.day.toString().padLeft(2, '0')}';
                        });
                      }
                    },
                  ),
                ),
                const Divider(),
                const Text('Enter the building in which you got married:'),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: description,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                if (errorText != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      errorText!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (_answersAreCorrect(pickedDate, description.text)) {
                    Navigator.pop(dialogContext, true);
                  } else {
                    setState(() {
                      errorText = 'That\'s not quite right. Try again!';
                    });
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          );
        },
      );
    },
  );

  dateControl.dispose();
  description.dispose();

  return result ?? false;
}

/// Returns `true` when the picked date matches [_correctDate] (comparing only
/// the calendar day) and the location contains [_correctLocationKeyword].
bool _answersAreCorrect(DateTime? pickedDate, String location) {
  final dateMatches = pickedDate != null &&
      pickedDate.year == _correctDate.year &&
      pickedDate.month == _correctDate.month &&
      pickedDate.day == _correctDate.day;
  final locationMatches =
      location.toLowerCase().contains(_correctLocationKeyword);
  return dateMatches && locationMatches;
}
