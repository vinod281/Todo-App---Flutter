import 'package:app2/Models/todo.dart';
import 'package:app2/widgets/todoItem.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todos = Todo.todoList();
  List<Todo> _searchTodo = [];
  TextEditingController todoController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _searchTodo = todos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.menu, color: Colors.white),
            ),
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/3135823.png'),
            ),
          ],
        ),
      ),
      body: _body(),
    );
  }

  _body() {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _searchBar(),
            _todos(),
            _input(),
          ],
        )
      ],
    );
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: TextField(
            onChanged: (value) => search(value),
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  _todos() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("All Todos"),
            Expanded(child: ListView(
              children: [
                for(Todo todo in _searchTodo.reversed)
                TodoItem(todo: todo, onDelete:(){
                  setState(() {
                    _searchTodo.remove(todo);
                  });
                }, onClick:(){
                  setState(() {
                    todo.isDone = !todo.isDone;
                  });
                })
                
              ],
            ),)
          ],
        ),
    ));
  }

  _input() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: 
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: todoController,
                    decoration: InputDecoration(
                      hintText: 'Add a new todo',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              
              IconButton(
                onPressed: () {
                  setState(() {
                    _searchTodo.add(Todo(id:"17", title: todoController.text));
                    todoController.clear();
                  });
                },
                icon: Icon(Icons.add),
              ),
            ],
          ),
        
        ),
      ),
    );
  }

  void search(String text)
  {
    List<Todo> result = [];

    if(text.isEmpty)
    {
      result = todos;
    }
    else
    {
      result = todos.where((todo) => todo.title.toLowerCase().contains(text.toLowerCase())).toList();
    }

    setState(() {
      _searchTodo = result;
    });
  }

}


