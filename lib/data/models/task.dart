//Aquí voy definiendo una clase task con id()

class Task {
  final int? id;// aquí esta nuleable pq sqlite hace el id aleatoriamente, entonces no lo tenemos al crear una tarea. el id se crea es ya cuando entra a la base de datos 
  String title;
  bool isCompleted;

  Task({this.id, required this.title, this.isCompleted = false});
//convierte una tarea a un mapa para sqlite 

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }


//convierte un registro sqlite en un objeto task ( es decir cuando se lo trae lo trae como un task )

//Factory 
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],// aqui recuperamos el id que se generó y lo agregamos al task 
      title: map['title'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
}
