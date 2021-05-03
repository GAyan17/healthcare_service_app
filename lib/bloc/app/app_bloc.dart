import 'dart:async';

import 'package:auth_repo/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pedantic/pedantic.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(authRepository.currentUser.isNotUser
            ? Authenticated(authRepository.currentUser)
            : const Unauthenticated()) {
    _userSubscription = _authRepository.user.listen(_onUserChanged);
  }

  final AuthRepository _authRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(User user) => add(AppUserChanged(user));

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is AppUserChanged) {
      yield _mapUserChangedToState(event, state);
    } else if (event is AppLogOutRequested) {
      unawaited(_authRepository.logout());
    }
  }

  AppState _mapUserChangedToState(AppUserChanged event, AppState state) {
    return event.user.isNotUser
        ? Authenticated(event.user)
        : const Unauthenticated();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
