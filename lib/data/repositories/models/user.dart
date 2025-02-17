import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    this.email,
    this.name,
  });

  final String? email;

  final String id;

  final String? name;

  static const empty = User(id: '');

  @override
  List<Object?> get props => [
        email,
        id,
        name,
      ];
}
