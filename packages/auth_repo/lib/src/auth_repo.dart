import 'dart:async';

import 'package:auth_repo/src/exceptions.dart';
import 'package:cache_client/cache_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';

import '../src/models/user.dart';

class AuthRepository {
  AuthRepository(
      {firebase_auth.FirebaseAuth? firebaseAuth,
      FirebaseFirestore? firebaseFirestore,
      CacheClient? cacheClient})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _firestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _cacheClient = cacheClient ?? CacheClient();

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final CacheClient _cacheClient;
  late final User _user;

  static const String userCollection = 'customers';

  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  Stream<User> get user =>
      _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
        if (firebaseUser != null) {
          var documentSnapshot = await _firestore
              .collection(userCollection)
              .doc(firebaseUser.uid)
              .get();
          _user = User.fromJson(documentSnapshot.data()!);
          return _user;
        }
        _user = User.nouser;
        return _user;
      });

  // User get currentUser => _cacheClient.read(key: userCacheKey) ?? User.nouser;
  User get currentUser => _user;

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required DateTime dob,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      var firebaseUser = _firebaseAuth.currentUser!;
      var newUser = User(
        id: firebaseUser.uid,
        email: firebaseUser.email,
        name: name,
        dob: dob,
      );
      await _firestore
          .collection(userCollection)
          .doc(firebaseUser.uid)
          .set(newUser.toJson());
    } on Exception {
      throw SignUpFailure();
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on Exception {
      throw LogOutFailure();
    }
  }
}
