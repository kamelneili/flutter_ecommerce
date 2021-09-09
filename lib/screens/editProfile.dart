import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technoshop/blocs/Auth_bloc.dart';
import 'package:technoshop/event/auth_event.dart';
import 'package:technoshop/repository/auth_repository.dart';
import 'package:technoshop/screens/constants.dart';
import 'package:technoshop/screens/navigation_drawer.dart';
import 'package:technoshop/screens/profile.dart';
import 'package:technoshop/state/auth_state.dart';
//import 'package:newsapp/api/authentication_api.dart';

class EditProfile extends StatefulWidget {
  @override
  String name;
  String email;
  String phone;
  EditProfile(this.phone, this.name, this.email);
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  //AuthenticationAPI authenticationAPI = AuthenticationAPI();
  bool isLoading = false;

  bool loginError = false;
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  TextEditingController password = TextEditingController();
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  AuthBloc authBloc;
  AuthRepository repo;
  String username;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    email = TextEditingController(text: widget.email);
    name = TextEditingController(text: widget.name);
    password = TextEditingController();

    phone = TextEditingController(text: widget.phone);
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                backgroundColor:  kPrimaryColor,
        centerTitle: true,
        title: Text('Edit Profile'),
      ),
      drawer: NavigationDrawer(),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is RegisterLoadingState) {
            return Center(child: CircularProgressIndicator());

            _drawLoading();
          } else if (state is UserRegisterSuccessState) {
            Navigator.pushNamed(context, '/');
          }
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: (isLoading) ? _drawLoading() : _drawLoginForm(),
        ),
      ),
    );
  }

  Widget _drawLoginForm() {
    if (loginError) {
      return Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Login Error'),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    loginError = false;
                  });
                },
                child: Text(
                  'try Again',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      );
    }
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: name,
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          TextFormField(
            controller: phone,
            decoration: InputDecoration(labelText: 'Phone'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your phone';
              }
              return null;
            },
          ),
          TextFormField(
            controller: email,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your Email';
              }
              return null;
            },
          ),
          SizedBox(
            height: 48,
          ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              color: kPrimaryColor,
              onPressed: () {
                authBloc.add(UpdateButtonPressed(
                    phone: phone.text, name: name.text, email: email.text));
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Profile();
                }));
              },
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _drawLoading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
