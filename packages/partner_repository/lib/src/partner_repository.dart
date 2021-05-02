import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../partner_repository.dart';

class PartnerRepository {
  PartnerRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const String _partnerCollection = 'partners';

  Stream<List<HealthCareServicePartner>> getPartners() {
    return _firestore
        .collection(_partnerCollection)
        .snapshots()
        .map((querySnap) {
      return querySnap.docs.map((docSnap) {
        return HealthCareServicePartner.fromJson(docSnap.data());
      }).toList();
    });
  }
}
