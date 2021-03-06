// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:todo_app/models/toDo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> todos = dataTodo;

  @override
  Widget build(BuildContext context) {
    AppBar myAppBar = AppBar(
      title: Text("Todo App"),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
    );

    // Mencari size hp user
    double heihtbody = MediaQuery.of(context).size.height -
        myAppBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    double withbody = MediaQuery.of(context).size.width;

    // Function search
    void searchTodo(String query) {
      final todoFilter = dataTodo.where((todo) {
        // Mendebug kapital ke semua huruf jadi lowercase
        final todoTitle = todo.title.toLowerCase();
        final input = query.toLowerCase();
        return todoTitle.contains(input);
      }).toList();
      setState(
        () {
          todos = todoFilter;
        },
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'addTodo');
        },
        child: Icon(Icons.add),
      ),
      appBar: myAppBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              height: heihtbody * 0.15,
              width: withbody,
              child: TextField(
                onChanged: searchTodo,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    hintText: "Search your task.."),
              ),
            ),
            todos.length != 0
                ? Container(
                    height: heihtbody * 0.85,
                    width: withbody,
                    child: ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: ((context, index) {
                        final todo = todos[index];
                        return CheckboxListTile(
                          secondary: IconButton(
                            onPressed: () {
                              setState(() {
                                todos.removeAt(index);
                              });
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(
                            todo.title,
                            style: TextStyle(
                                fontSize: 16,
                                decoration: todo.isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                          subtitle: Text(todo.desc),
                          value: todo.isCompleted,
                          onChanged: (value) {
                            setState(
                              () {
                                todo.isCompleted = value!;
                              },
                            );
                          },
                        );
                      }),
                    ),
                  )
                : Container(
                    child: Text("Data kosong!"),
                  ),
          ],
        ),
      ),
    );
  }
}
