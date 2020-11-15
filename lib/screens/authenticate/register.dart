import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import '../../services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register(this.toggleView);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  final email = TextEditingController();
  final pass = TextEditingController();
  final passCheck = TextEditingController();
  bool isLoading = false;
  String error = '';
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Sign in'))
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image.network(
                          'https://raw.githubusercontent.com/putraxor/flutter-login-ui/master/assets/logo.png'),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Enter Email",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                        validator: (value) =>
                            value.isEmpty ? 'Please enter a value' : null,
                        onChanged: (val) {},
                        controller: email,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Enter Password",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                        validator: (value) => value.length < 6
                            ? 'Length of the password should be more than 6'
                            : null,
                        obscureText: true,
                        onChanged: (val) {},
                        controller: pass,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Confirm password",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                        validator: (value) =>
                            value != pass.text ? 'Passwords must match' : null,
                        obscureText: true,
                        onChanged: (val) {},
                        controller: passCheck,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50.0,
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              dynamic result =
                                  await _auth.registerWithEmailAndPass(
                                      email.text, pass.text);
                              if (result == null) {
                                setState(() {
                                  error =
                                      'Please enter valid values in the fields';
                                  isLoading = false;
                                });
                              }
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff374ABE),
                                    Color(0xff64B6FF)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Container(
                              // constraints: BoxConstraints(
                              //     maxWidth: 300.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Register",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
