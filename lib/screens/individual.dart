import 'package:brew_crew/models/indiChar.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Individual extends StatefulWidget {
  String name;
  Individual(this.name);

  @override
  _IndividualState createState() => _IndividualState();
}

class _IndividualState extends State<Individual> {
  bool isLoading = true;
  var _individual = List<IndiChar>();
  Future<List<IndiChar>> func() async {
    String _name = widget.name;
    _name = _name.replaceAll(' ', '+');
    final url =
        'https://www.potterapi.com/v1/characters?key=\$2a\$10\$XYLu2gP03HgQgmhfIrqryOXHIvmpahVOgPNyrBkR2ltUol0jRS4eK&name=$_name';
    final response = await http.get(url);
    var individual = List<IndiChar>();
    if (response.statusCode == 200) {
      var indisJson = json.decode(response.body);
      for (var indiJson in indisJson) {
        individual.add(IndiChar.fromJson(indiJson));
      }
    }
    return individual;
  }

  @override
  void initState() {
    // TODO: implement initState
    func().then((value) {
      setState(() {
        _individual.addAll(value);
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
              title: Text(widget.name),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      // color: Color(0xffFFB157),
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Expanded(
                          child: Text(
                            _individual[0].name,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      // color: Color(0xffFFB157),
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Expanded(
                          child: Column(
                            children: [
                              _view('Patronus', _individual[0].patronus),
                              _view('Blood Status', _individual[0].bloodStatus),
                              _view('House', _individual[0].house),
                              _view('School', _individual[0].school),
                              _view('Alias', _individual[0].alias),
                              _view('Wand', _individual[0].wand),
                              _view('Boggart', _individual[0].boggart),
                              _view(
                                  'Was in ministry of magic?',
                                  _individual[0].ministryOfMagic
                                      ? 'Yes'
                                      : 'No'),
                              _view(
                                  'Was in Order of pheonix?',
                                  _individual[0].orderOfThePhoenix
                                      ? 'Yes'
                                      : 'No'),
                              _view(
                                  'Was in Dumbeldore\'s army?',
                                  _individual[0].dumbledoresArmy
                                      ? 'Yes'
                                      : 'No'),
                              _view('Was death eater?',
                                  _individual[0].deathEater ? 'Yes' : 'No'),
                              _view('Species', _individual[0].species),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

_view(name, val) {
  return Column(
    children: [
      SizedBox(
        height: 10,
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Expanded(
                child: Text(
                  name + ' ',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Expanded(
                child: Text(
                  val,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
