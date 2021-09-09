import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technoshop/blocs/Auth_bloc.dart';
import 'package:technoshop/blocs/Cart_bloc%20.dart';
import 'package:technoshop/event/auth_event.dart';
import 'package:technoshop/models/nav_menu.dart';
import 'package:technoshop/repository/auth_repository.dart';
import 'package:technoshop/screens/cartItems.dart';
import 'package:technoshop/screens/catalogue.dart';
import 'package:technoshop/screens/constants.dart';
import 'package:technoshop/screens/home.dart';
import 'package:technoshop/screens/login.dart';
import 'package:technoshop/screens/orders.dart';
import 'package:technoshop/screens/profile.dart';
import 'package:technoshop/screens/register.dart';
import 'package:technoshop/screens/view/LoginPage.dart';
//import 'package:kmlnewsapp/models/nav_menu.dart';

//import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  //**** */
  List<NavMenuItem> navigationMenu = [
    NavMenuItem("Home", () => HomePage()),
    NavMenuItem("Catalogue", () => Catalogue()),
    // NavMenuItem("Home", () => HomePage()),

    //NavMenuItem("Register", () => Register()),
    //NavMenuItem("My Profile", () => {Profile()}),
//    NavMenuItem("Register", () => FacebookFeeds() ),
  ];
  List<Icon> iconsMenu = [
    Icon(Icons.home, color: kSecondaryColor),
    Icon(Icons.dashboard, color: kSecondaryColor),
    //Icon(Icons.shopping_basket, color: kSecondaryColor),
  ];
  //
  static bool isLoggedIn = false;

  String token;

  SharedPreferences sharedPreferences;

  Future _checkToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token');
    // print(token);
    setState(() {
      if (token == null) {
        isLoggedIn = false;
      } else {
        isLoggedIn = true;
      }
    });
  }

  AuthRepository repo;
  _logout() {
    if (sharedPreferences != null) {
      sharedPreferences.remove('token');
      //repo.unsetLocalToken(token);
    }
    return HomePage();
  }

  @override
  void initState() {
    _checkToken();
    String name = '';
    if (isLoggedIn) {
      //  name
      navigationMenu.add(NavMenuItem("My Orders", () => Orders()));
      iconsMenu.add(
        Icon(
          Icons.bookmark_border,
          color: kSecondaryColor,
        ),
      );

      navigationMenu.add(
        NavMenuItem("My Profile", () => Profile()),
      );
       iconsMenu.add(
        Icon(
          Icons.person,
          color: kSecondaryColor,
        ),
      );
   navigationMenu.add(NavMenuItem("Logout", _logout));
     iconsMenu.add(
        Icon(Icons.exit_to_app, color: kSecondaryColor),
      );
    

      
    } else {
      navigationMenu.add(NavMenuItem("Register", () => Register()));
      navigationMenu.add(
        NavMenuItem("LogIn", () => Login()),
      );
      iconsMenu.add(
        Icon(Icons.person, color: kSecondaryColor),
      );
      iconsMenu.add(
        Icon(Icons.transit_enterexit, color: kSecondaryColor),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: kPrimaryColor,
        child: Padding(
          padding: EdgeInsets.only(top: 75, left: 24),
          child: ListView.builder(
            itemBuilder: (context, position) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: InkWell(
                  child: ListTile(
                    title: Text(
                      navigationMenu[position].title,
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    leading:
                        /*Icon(
                       style: TextStyle(
                  color: Colors.white,
                ),
                      Icons.chevron_right,
                      color: Colors.grey.shade400,
                    ),*/
                        iconsMenu[position],
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  navigationMenu[position].destination()));
                    },
                  ),
                ),
              );
            },
            itemCount: navigationMenu.length,
          ),
        ),
      ),
    );
  }
}
