import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:tasks_app/tasks_model.dart';
import 'package:flutter/services.dart' as rootBundle;

class HeatMap extends StatefulWidget {
  const HeatMap({super.key});

  @override
  State<HeatMap> createState() => _HeatMapState();
}

class _HeatMapState extends State<HeatMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tasks Heat Map"),
        ),
        body: FutureBuilder(
            future: ReadJsonData(),
            builder: (context, data) {
              if (data.hasError) {
                return Center(child: Text("$data.error"));
              } else if (data.hasData) {
                var items = data.data as List<TasksModel>;

                return HeatMapCalendar(
                  defaultColor: Colors.white,
                  flexible: true,
                  colorMode: ColorMode.color,
                  datasets: {
                    DateTime(2024, 1, 6): 6,
                    DateTime(2024, 1, 7): 5,
                    DateTime(2024, 1, 8): 6,
                    DateTime(2024, 1, 9): 1,
                    DateTime(2024, 1, 13): 4,
                    DateTime(2024, 2, 1): 2,
                    DateTime(2024, 2, 3): 6,
                    DateTime(2024, 2, 9): 5,
                  },
                  colorsets: const {
                    1: Color.fromARGB(255, 200, 230, 201),
                    2: Color.fromARGB(255, 129, 199, 132),
                    3: Color.fromARGB(255, 76, 175, 80),
                    4: Color.fromARGB(255, 56, 142, 60),
                    5: Color.fromARGB(255, 76, 175, 80),
                    6: Color.fromARGB(255, 18, 134, 22),
                  },
                  onClick: (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(value.toString())));
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  Future<List<TasksModel>> ReadJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('tasksFile/tasks.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => TasksModel.fromJson(e)).toList();
  }
}
