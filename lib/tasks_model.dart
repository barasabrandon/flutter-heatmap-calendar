class TasksModel {
  int? id;
  String? date;
  String? score;
  List<String>? tasks;

  TasksModel({this.id, this.date, this.score, this.tasks});

  TasksModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    date = json["date"];
    date = json["date"];
    tasks = List<String>.from(json['tasks'] ?? []);
  }
}
