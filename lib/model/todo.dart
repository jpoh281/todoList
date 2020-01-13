class Todo{
  String title;
  bool completed;

  Todo({
    this.title,
    this.completed = false
  });

  Todo.fromMap(Map<String, dynamic> map) :
      title = map['Title'],
      completed = map['completed'];

  updateTitle(title){
    this.title = title;
  }

  Map toMap(){
    return {
      'title' : title,
      'completed' : completed
    };
  }
}