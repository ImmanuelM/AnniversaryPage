import 'package:flutter/material.dart';

Widget secretMessage(bool status) {
  return const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Happy Anniversary Qian Qian',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Divider(),
      Text(''' It's Been the most Wonderful 6 Years!\n 
Your Sweetness has grown over the years... \nand also making sure I do not step on your toes when kissing has grown over the years \n
Love you as a Mom, Love you as a Sweetie Pie. \n
Lovely Sweetie, Blessed Sweetie! 
''')
    ],
  );
}
