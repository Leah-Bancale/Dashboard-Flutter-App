import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  TextEditingController _postController = TextEditingController();
  List<String> _posts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.redAccent,
        actions: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    right: 16.0),
                child: IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    Navigator.pushNamed(context, '/user_profile');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 50.0,
            ).add(
              EdgeInsets.only(
                  top:
                      80.0),
            ),
            child: TextField(
              controller: _postController,
              decoration: InputDecoration(labelText: 'Enter a post'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0), 
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _posts.add(_postController.text);
                  _postController.clear();
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              child: Text('Post'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          50.0), 
                  child: ListTile(
                    title: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              0.0),
                      child: Text(_posts[index]),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
