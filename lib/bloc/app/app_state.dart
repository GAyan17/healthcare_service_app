part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();
}

class Authenticated extends AppState {
  final User user;

  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class Unauthenticated extends AppState {
  const Unauthenticated();

  @override
  List<Object?> get props => [];
}
