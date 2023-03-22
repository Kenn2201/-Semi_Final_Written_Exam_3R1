
import 'package:crudsql/profilepageadd.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                    color: Colors.yellow,
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
                  '3-R1',
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Successfully Logged Out!'),
                      backgroundColor: Colors.orangeAccent,
                    ),
                  );
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: ()async{
          await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddProfile())
          );
        },
      ),

    );
  }
}
