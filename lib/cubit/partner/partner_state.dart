part of 'partner_cubit.dart';

abstract class PartnerState extends Equatable {
  const PartnerState();

  @override
  List<Object> get props => [];
}

class PartnerInitial extends PartnerState {}

class PartnerRecieved extends PartnerState {
  final List<HealthCareServicePartner> partners;

  const PartnerRecieved({required this.partners});

  @override
  List<Object> get props => [partners];
}
