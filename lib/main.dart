import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Users'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

//getMethod for Json User List
  Future<List<User>> _getUsers() async {
    var data = await http.get("https://jsonplaceholder.typicode.com/users");

    var jsonData = json.decode(data.body);

    List<User> users = [];
    for (var u in jsonData){

      User user = User(u["id"], u["name"], u["username"], u["email"], u["phone"]);

      users.add(user);
    }

    print(users.length);
    return users;

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        title: Text(widget.title,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
      ),
      body: Container(
        child: FutureBuilder(
          future: _getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot){

            if (snapshot.data == null){
              return Container(

                child: Center(
                  child: CircularProgressIndicator()
                )
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int id) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/clipart_.png'),
                      backgroundColor: Colors.purple,
                    ),
                    title: Text(
                      snapshot.data[id].name,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    subtitle: Text(
                      snapshot.data[id].email,
                      style: TextStyle(
                        fontFamily: 'Montserrat'
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[id]))
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

//Class to display more info about user
class DetailPage extends StatelessWidget {

  final User user;

  DetailPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        title: Text(user.name,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 180.0),
                  child: Text(
                    'Name: ' + user.name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Montserrat'
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 230.0),
                  child: Text(
                    'Username: ' + user.username,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Montserrat'
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 280.0),
                  child:
                  Text(
                    'Email: ' + user.email,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Montserrat'
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 330.0),
                  child: Text(
                    'Phone: ' + user.phone,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Montserrat'
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 25.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/clipart_.png'),
                    backgroundColor: Colors.purple,
                    radius: 60.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}

// User Class
class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;

  User(this.id, this.name, this.username, this.email, this.phone);
}