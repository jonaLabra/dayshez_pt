// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Userdata extends Equatable {
  final String? name;
  final String? email;
  final String? photoUrl;

  const Userdata({required this.name, required this.email, this.photoUrl});

  set nameset(String names) {
    //this.name = names;
  }

  String get nameget => name!;

  set emailset(String names) {
    //this.name = names;
  }

  String get emailget => name!;

  set tokensset(String token) {
    //tokens!.add(token);
  }

  //List get tokensget => tokens!;

  static const empty = Userdata(name: '', email: '', photoUrl: '');

  bool get isEmpty => this == Userdata.empty;
  bool get isNotEmpty => this != Userdata.empty;

  @override
  List<Object?> get props => [name, email, photoUrl];
}
