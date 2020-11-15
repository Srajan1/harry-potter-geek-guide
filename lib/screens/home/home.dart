import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/card.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Geeeky harry potter guide"),
        actions: [
          FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text(
                'logout',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            CardClass('Characters', Color(0xff6DC8F3), Color(0xff73A1F9)),
            SizedBox(
              height: 20,
            ),
            CardClass('Spells', Color(0xffFFB157), Color(0xffFFA057)),
            SizedBox(
              height: 20,
            ),
            CardClass('Houses', Color(0xffD76EF5), Color(0xff8F7AFE)),
          ],
        ),
      ),
    );
  }
}
