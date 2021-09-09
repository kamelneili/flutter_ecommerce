import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technoshop/blocs/Auth_bloc.dart';
import 'package:technoshop/event/auth_event.dart';
import 'package:technoshop/repository/auth_repository.dart';
import 'package:technoshop/screens/constants.dart';
import 'package:technoshop/screens/editProfile.dart';
import 'package:technoshop/screens/navigation_drawer.dart';
import 'package:technoshop/state/auth_state.dart';
//import 'package:newsapp/api/authentication_api.dart';

class Profile extends StatefulWidget {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  //    int userId = prefs.getInt('id');

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
//******* */

  @override
  void initState() {
    //SharedPreferences pref = await SharedPreferences.getInstance();
    //   int userId = pref.getInt('id');
    //print(userId);
    //    String token = pref.getString('token');
    //    String name = pref.getString('name');

    authBloc = BlocProvider.of<AuthBloc>(context);

    TextEditingController email = TextEditingController();
    TextEditingController myname = TextEditingController();

    TextEditingController password = TextEditingController();
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(DisplayProfileEvent());

    //getPrefs();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => prefs = prefs);
    });
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
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text('My Profile'),
      ),
            drawer: NavigationDrawer(),

      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is ProfilLoadingState) {
            return Center(child: CircularProgressIndicator());

            _drawLoading();
          } else if (state is UserRegisterSuccessState) {
            Navigator.pushNamed(context, '/home');
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
    //   _getPrefs();
    SharedPreferences prefs;
    Future<dynamic> getPrefs() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      return prefs;
    }

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is DisplayProfileState) {
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.person,
                      color: kSecondaryColor,
                    ),
                    Text(
                      'Name',
                      style: TextStyle(
                          color: kSecondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 85),
                    Text(state.user.name.toString()),
                  ],
                ),

                SizedBox(
                  height: 48,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Icon(
                      Icons.mail,
                      color: kSecondaryColor,
                    ),
                    Text(
                      // controller: name,
                      'Email',
                      style: TextStyle(
                          color: kSecondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 85),
                    Text(state.user.email.toString()),
                  ],
                ),

                SizedBox(
                  height: 48,
                ),
                Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Icon(
                      Icons.phone,
                      color: kSecondaryColor,
                    ),
                    Text(
                      // controller: name,
                      'Phone',
                      style: TextStyle(
                          color: kSecondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 85),
                    Text(state.user.phone.toString()),
                  ],
                ),

                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: kPrimaryColor,
                    child: Text(
                      "Edit",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      email = TextEditingController(
                          text: state.user.email.toString());
                      name = TextEditingController(
                          text: state.user.name.toString());
                      password = TextEditingController();

                      phone = TextEditingController(
                          text: state.user.phone.toString());

                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              title: Text('Edit'),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        controller: name,
                                        decoration: InputDecoration(
                                          labelText: 'Name',
                                          icon: Icon(
                                            Icons.account_box,
                                            color: kSecondaryColor,
                                          ),
                                        ),
                                      ),
                                      TextFormField(
                                        controller: email,
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                          icon: Icon(
                                            Icons.email,
                                            color: kSecondaryColor,
                                          ),
                                        ),
                                      ),
                                      TextFormField(
                                        controller: phone,
                                        decoration: InputDecoration(
                                          labelText: 'Phone',
                                          icon: Icon(
                                            Icons.phone,
                                            color: kSecondaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                RaisedButton(
                                    color: kPrimaryColor,
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      // your code

                                      authBloc.add(UpdateButtonPressed(
                                          phone: phone.text,
                                          name: name.text,
                                          email: email.text));
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return Profile();
                                      }));
                                    })
                              ],
                            );
                          });
                    },
                  ),
                ),

                // backgroundColor:Colors.white,
                // heroTag: Text("btn1"),
                /*    InkWell(
                                      child: Container(
                     padding: EdgeInsets.symmetric(
                       horizontal: kDefaultPadding /2, // 30 px padding
                       vertical: kDefaultPadding / 3, // 5 px padding
                     ),
                     decoration: BoxDecoration(
                       color: kSecondaryColor,
                       borderRadius: BorderRadius.circular(22),
                     ),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text('Edit'),
                        //  Icon(Icons.arrow_right),

                       ],
                     ),
                 ),
                 onTap: () {},
                  ),
                  */
                // color: Colors.red,
              ],
            ),
          );
        }
      },
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
