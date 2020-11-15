import 'package:brew_crew/screens/individual.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/characteModel.dart';

class Character extends StatefulWidget {
  final title;
  Character(this.title);
  @override
  _CharacterState createState() => _CharacterState();
}

class _CharacterState extends State<Character> {
  List<Char> _chars = List<Char>();
  List<Char> _charsForDisplay = List<Char>();
  bool isLoading = true;
  final url =
      'https://www.potterapi.com/v1/characters?key=\$2a\$10\$XYLu2gP03HgQgmhfIrqryOXHIvmpahVOgPNyrBkR2ltUol0jRS4eK';

  Future<List<Char>> func() async {
    final response = await http.get(url);
    var chars = List<Char>();
    if (response.statusCode == 200) {
      var charsJson = json.decode(response.body);
      for (var charJson in charsJson) {
        chars.add(Char.fromJson(charJson));
      }
    }
    return chars;
  }

  @override
  void initState() {
    // TODO: implement initState
    func().then((value) {
      setState(() {
        _chars.addAll(value);
        _charsForDisplay = _chars;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: Column(
              children: [
                Form(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      TextField(
                        onChanged: (text) {
                          setState(() {
                            _charsForDisplay = _chars.where((element) {
                              var charTitle = element.name.toLowerCase();
                              return charTitle.contains(text);
                            }).toList();
                          });
                        },
                        decoration: new InputDecoration(
                          labelText: "Enter Name of character",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                    ],
                  ),
                ),
                new Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return _listView(index, _charsForDisplay, context);
                    },
                    itemCount: _charsForDisplay.length,
                  ),
                )
              ],
            ),
          );
  }
}

_listView(index, _charsForDisplay, context) {
  return Card(
      child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _charsForDisplay[index].name,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ),
          Row(
            children: [
              Text(
                'Patronus ',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                _charsForDisplay[index].patronus,
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'House ',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                _charsForDisplay[index].house,
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Blood Status ',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                _charsForDisplay[index].bloodStatus,
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Individual(_charsForDisplay[index].name)),
                    );
                  },
                  icon: Icon(Icons.info),
                  label: Text('View in detail')),
            ],
          )
        ],
      ),
    ),
  ));
}
