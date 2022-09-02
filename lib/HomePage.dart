import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List posts = [];
  Future getPost() async {
    var url = 'https://jsonplaceholder.typicode.com/todos';
    var response = await http.get(Uri.parse(url));
    var responseBody = jsonDecode(response.body);
    setState(() {
      posts.addAll(responseBody);
    });
  }

  @override
  void initState() {
    getPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: posts.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: posts.length,
              itemBuilder: (context, i) {
                return Card(
                  color: posts[i]['completed'] == true
                      ? Colors.lightBlueAccent
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  shadowColor: Colors.blue,
                  child: CheckboxListTile(
                    contentPadding: EdgeInsets.all(10),
                    value: posts[i]['completed'] == true,
                    onChanged: (val) {
                      setState(() {
                        posts[i]['completed'] = val;
                      });
                    },
                    title: Text(
                      '${posts[i]['title']}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    //  Text('${posts[i]['completed']}'),
                  ),
                );
              },
            ),
    );
  }
}
