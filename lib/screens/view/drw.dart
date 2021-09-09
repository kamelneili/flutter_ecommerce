
                    color: kPrimaryColor,
                    onPressed: () {
                      //  authBloc.add(UpdateButtonPressed( phone:phone.text,name: name.text,email: email.text, password: password.text));

                      //Navigator.pushNamed(context, '/catalogue');
                      // Navigator.pushNamed(context, '/h');
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return EditProfile(state.user.phone, state.user.name,
                            state.user.email);
                      }));
                      //  Navigator.of(context).pushNamed('/catalogue');
                    },
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  