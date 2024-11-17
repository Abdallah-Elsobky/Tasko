import 'package:flutter/material.dart';

class Task {
  final int id;
  final String title;
  final String description;
  final String date;
  final String time;
  final String status;
  final int type;
  final int color;
  String date_format;
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.status,
    required this.type,
    required this.color,
    required this.date_format,
  });
}
