import 'package:firebase_auth/firebase_auth.dart';

import 'add_todo.dart';
import 'todo_model.dart';
import 'todo_info.dart';
import 'update_todo.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List todos = <dynamic>[];
  final currentuser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text('About Me'),
        elevation: 0,
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.yellow[200],
        child: SizedBox(
          height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
               DrawerHeader(
                decoration: const BoxDecoration(
                    color: Colors.yellow
                ),
                child: Text(
                  'Signed In as: \n${currentuser.email!}',
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text(
                  'Developed By:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Kenn Vincent A. Nacario',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text(
                  'From Section:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '3R-1',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text(
                  'Software Version',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '1.2',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ),

              const Divider(height: 300,),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text(
                  'Log-out',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Tap here!',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                },
              ),

            ],
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder<List<TodoItem>>(
          future: DatabaseHelper.instance.getTodoItems(),
          builder: (context, AsyncSnapshot<List<TodoItem>> snapshot){
            if(snapshot.hasData){
              print('${snapshot.data} snapshot');

              if(snapshot.data!.isEmpty){

                return const Center(
                  child: Text('no data'),
                );


              }else{
                todos.isEmpty ? todos = snapshot.data! : null;
                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context,index){
                    final todoItem = todos[index];
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction)async{
                        await DatabaseHelper.instance.remove(todoItem.id!);
                        setState(() {
                          todos.removeAt(index);

                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${todoItem.name} Item Successfully deleted!')));
                        print(snapshot.data);
                      },
                      child: ListTile(
                        title: Text('${todoItem.name}'),
                        trailing: ElevatedButton(
                          onPressed: ()async{
                            var updatedTodo1 = await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => UpdateTodo(updatedTodo:todoItem,))
                            );
                            await DatabaseHelper.instance.update(updatedTodo1,todoItem.id);

                            setState(() {
                              todos[index] = updatedTodo1;
                            });
                          },
                          child: const Text('Update'),

                        ),
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ToDoInfo(todo:todoItem,))
                          );
                        },
                      ),
                      //DatabaseHelper.instance.remove(todoItem.id!);
                    );
                  },
                );
              }
            }
            return const Center(child: Text('loading...'));
            //return snapshot.data!.isEmpty ? Center(child: Text('No items in ToDo.'))
                //:
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: ()async{
          var result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddTodo())
          );
          setState(() {
            todos.add(result);
          });
        },
      ),
    );
  }
}
