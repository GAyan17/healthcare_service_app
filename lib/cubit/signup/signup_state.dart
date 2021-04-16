part of 'signup_cubit.dart';

class SignupState extends Equatable {
  const SignupState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
    this.name = '',
    this.age,
    this.dob,
  });

  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;
  final String name;
  final int? age;
  final DateTime? dob;

  @override
  List<Object?> get props =>
      [email, password, confirmedPassword, status, name, age, dob];

  SignupState copyWith({
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
    String? name,
    int? age,
    DateTime? dob,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
      name: name ?? this.name,
      age: age ?? this.age,
      dob: dob ?? this.dob,
    );
  }
}
