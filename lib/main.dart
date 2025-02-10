import 'package:flutter/material.dart';
import 'package:test_project/models/todo_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  List<ToDo> todoList = [ToDo(title: 'SHop')];
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();

// ----------ToDo AddPopup Model Fun Start------------
  void openAddTodoForm() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add ToDo'),
            content: Form(
                key: formKey,
                child: TextFormField(
                  controller: titleController,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      label: Text('Item'), border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Item';
                    }
                  },
                )),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      titleController.clear();
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Close')),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        addToDoItem(titleController.text);
                      });
                      Navigator.pop(context);
                    }
                    titleController.clear();
                  },
                  child: Text('Add')),
            ],
          );
        });
  }

  // -----------------------Add function start---------------------
  void addToDoItem(String itemData) {
    setState(() {
      // bool filterList =
      //     todoList.where((item) => item.title != titleController.text);
      // List<ToDo> filterData = [];
      // todoList.where((item) {
      //   if (filterData.contains(item)) {
      //     return false;
      //   } else {
      //     return true;
      //   }
      // });
      todoList.add(ToDo(title: itemData.toString()));

      // for (int i = 0; i <= todoList.length; i++) {
      //   if (todoList[i].title) {}
      // }
      // print('filtersas $filterList');
      // if (filterList) (todoList.add(ToDo(title: itemData.toString())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Center(child: Container(child: Text('All Tasks'))),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              'LogOut',
              style: TextStyle(
                  color: const Color.fromARGB(255, 47, 12, 247),
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 50,
        child: Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            openAddTodoForm();
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
        shape: CircleBorder(),
        backgroundColor: const Color.fromARGB(255, 64, 162, 241),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // ---------------Body Part here---------------------
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 2, bottom: 2, right: 14, left: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      todoList[index].title,
                      style: TextStyle(fontSize: 19),
                    ),
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                // openEditTodoForm(todoList[index].title);
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Edit ToDo'),
                                        content: Form(
                                            key: formKey,
                                            child: TextFormField(
                                              controller: titleController,
                                              decoration: InputDecoration(
                                                  label: Text('Edit Item'),
                                                  border: OutlineInputBorder()),
                                            )),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('Close')),
                                          ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  todoList[index].title =
                                                      titleController.text;
                                                  titleController.clear();

                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: Text('Edit')),
                                        ],
                                      );
                                    });

                                titleController.text = todoList[index].title;
                              });
                            },
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 189, 147, 24),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          width: 0,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Are You Sure To Delete'),
                                      content: Container(
                                        height: 70,
                                        alignment: Alignment.center,
                                        child: Text(
                                          titleController.text =
                                              todoList[index].title,
                                          style: TextStyle(
                                              fontSize: 24, color: Colors.red),
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                titleController.clear();
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Text('Close')),
                                        ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                todoList.removeAt(index);
                                                titleController.clear();
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: Text('Delete')),
                                      ],
                                    );
                                  });
                            });
                          },
                          child: Text(
                            'Delete',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
