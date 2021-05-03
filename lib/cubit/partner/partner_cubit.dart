import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:partner_repository/partner_repository.dart';

part 'partner_state.dart';

class PartnerCubit extends Cubit<PartnerState> {
  PartnerCubit(this._partnerRepository) : super(PartnerInitial()) {
    _partnerSubscription = _partnerRepository.getPartners().listen(_onPartners);
  }

  final PartnerRepository _partnerRepository;
  late final StreamSubscription _partnerSubscription;

  void _onPartners(List<HealthCareServicePartner> partners) =>
      emit(PartnerRecieved(partners: partners));

  @override
  Future<void> close() {
    _partnerSubscription.cancel();
    return super.close();
  }

  Future<void> updateRating(
      {required String partnerId, required double rating}) async {
    final partner = await _partnerRepository.getPartner(partnerId: partnerId);
    var oneStar = partner.oneStarRatings!;
    var twoStar = partner.twoStarRatings!;
    var threeStar = partner.threeStarRatings!;
    var fourStar = partner.fourStarRatings!;
    var fiveStar = partner.fiveStarRatings!;
    if (rating == 1.0) {
      oneStar++;
    } else if (rating == 2.0) {
      twoStar++;
    } else if (rating == 3.0) {
      threeStar++;
    } else if (rating == 4.0) {
      fourStar++;
    } else if (rating == 5.0) {
      fiveStar++;
    }

    final totalRatings = oneStar + twoStar + threeStar + fourStar + fiveStar;

    var sum1 = (1 * (oneStar + 1) / (totalRatings + 5)) +
        (2 * (twoStar + 1) / (totalRatings + 5)) +
        (3 * (threeStar + 1) / (totalRatings + 5)) +
        (4 * (fourStar + 1) / (totalRatings + 5)) +
        (5 * (fiveStar + 1) / (totalRatings + 5));

    var sum2 = (1 * 1 * (oneStar + 1) / (totalRatings + 5)) +
        (2 * 2 * (twoStar + 1) / (totalRatings + 5)) +
        (3 * 3 * (threeStar + 1) / (totalRatings + 5)) +
        (4 * 4 * (fourStar + 1) / (totalRatings + 5)) +
        (5 * 5 * (fiveStar + 1) / (totalRatings + 5));

    var sum =
        sum1 - 1.65 * sqrt(((sum2 - (sum1 * sum1)) / (totalRatings + 5 + 1)));

    await _partnerRepository.updatePartner(
        partner: partner.copyWith(
      avgRating: sum,
      oneStarRatings: oneStar,
      twoStarRatings: twoStar,
      threeStarRatings: threeStar,
      fourStarRatings: fourStar,
      fiveStarRatings: fiveStar,
    ));
  }
}
