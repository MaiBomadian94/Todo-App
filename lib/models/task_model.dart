class TaskModel {
  String? id;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;

  TaskModel(
      {this.id,
      required this.isDone,
      required this.title,
      required this.description,
      required this.dateTime});

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'isDone': isDone
    };
  }

  factory TaskModel.fromFireStore(Map<String, dynamic> json) => TaskModel(
        id: json['id'],
        isDone: json['isDone'],
        title: json['title'],
        description: json['description'],
        dateTime: DateTime.fromMillisecondsSinceEpoch(json['dateTime']),
      );
}
