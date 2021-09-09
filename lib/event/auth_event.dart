import 'package:equatable/equatable.dart';

abstract class AuthEvents extends Equatable {
  @override
  List<Object> get props => [];
}
class StartEvent extends AuthEvents {}

class LoggedOut extends AuthEvents {}
class LogoutEvent extends AuthEvents{}
class LoginButtonPressed extends AuthEvents {
  final String email;
  final String password;

  LoginButtonPressed({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}
class DisplayProfileEvent extends AuthEvents{

}
class RegisterButtonPressed extends AuthEvents {
  final String email;
  final String password;
  final String name;
  final String phone;

  RegisterButtonPressed({this.phone,this.email, this.password,this.name});

  @override
  List<Object> get props => [email, password,name];
}
class UpdateButtonPressed extends AuthEvents {
  final String email;
  final String password;
  final String name;
  final String phone;

  UpdateButtonPressed({this.phone,this.email, this.password,this.name});

  @override
  List<Object> get props => [phone,email, password,name];
}
