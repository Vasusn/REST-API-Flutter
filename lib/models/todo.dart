class Todo {
  int? userID;
  int? id;
  String? title;
  bool? completed;

  Todo({this.userID, this.id, this.title, this.completed});

  Todo.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['id'] = this.id;
    data['title'] = this.title;
    data['completed'] = this.completed;
    return data;
  }
}
