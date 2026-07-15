import 'package:flutter/material.dart';

Future<bool> questions(BuildContext context) async {
  TextEditingController dateControl = TextEditingController();
  TextEditingController description = TextEditingController();
  bool success = false;
  String pickedLocation = '';
  DateTime? pickedDate;
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Answer the following Questions"),
          content: Column(
            children: [
              const Text('Enter the Date you gor married'),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                    controller: dateControl,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_month_rounded),
                    ),
                    onTap: () async {
                      pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2110));
                      dateControl.value =
                          TextEditingValue(text: (pickedDate!.toString()));
                    }),
              ),
              const Divider(),
              const Text('Enter the Building in which You got married:'),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: description,
                  keyboardType: TextInputType.multiline,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  pickedLocation = description.text;
                  if ((pickedDate == DateTime(2018, 11, 20)) &&
                      (pickedLocation.toLowerCase().contains('grace'))) {
                    success = true;

                    Navigator.pop(context);
                  }
                },
                child: const Text('Submit'))
          ],
        );
      });
  return success;
}
