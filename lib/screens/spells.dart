import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/spellsModel.dart';

class Spell extends StatefulWidget {
  @override
  _SpellState createState() => _SpellState();
}

class _SpellState extends State<Spell> {
  bool isLoading = true;
  List<Spells> _spells = List<Spells>();
  List<Spells> _spellsForDisplay = List<Spells>();

  final url =
      "https://www.potterapi.com/v1/spells?key=\$2a\$10\$XYLu2gP03HgQgmhfIrqryOXHIvmpahVOgPNyrBkR2ltUol0jRS4eK";

  Future<List<Spells>> func() async {
    final response = await http.get(url);
    var spells = List<Spells>();
    if (response.statusCode == 200) {
      var spellsJson = json.decode(response.body);
      for (var spellJson in spellsJson) {
        spells.add(Spells.fromJson(spellJson));
      }
    }
    print(spells);
    return spells;
  }

  @override
  void initState() {
    // TODO: implement initState
    func().then((value) {
      setState(() {
        _spells.addAll(value);
        _spellsForDisplay = _spells;
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
              title: Text('Spells'),
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
                        onChanged: (value) {
                          setState(() {
                            _spellsForDisplay = _spells.where((element) {
                              var charTitle = element.spell.toLowerCase();
                              return charTitle.contains(value);
                            }).toList();
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Enter spell',
                          border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
                new Expanded(
                    child: ListView.builder(
                  itemBuilder: (context, index) {
                    return _listView(index, _spellsForDisplay);
                  },
                  itemCount: _spellsForDisplay.length,
                ))
              ],
            ),
          );
  }
}

_listView(index, _spellsForDisplay) {
  return Card(
      child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _spellsForDisplay[index].spell,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Text(
                  'Effects ',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  _spellsForDisplay[index].effect,
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                'Type ',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                _spellsForDisplay[index].type,
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    ),
  ));
}
