import 'dart:async';

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
}
