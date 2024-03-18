// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'biometric_bloc.dart';

abstract class BiometricEvent {}

class ToggleBiometric extends BiometricEvent {
  final bool isBiometricEnabled;
  ToggleBiometric({
    required this.isBiometricEnabled,
  });
}

class BiometricTriesEvent extends BiometricEvent {
  final int tries;
  BiometricTriesEvent({
    required this.tries,
  });
}

class IsAuthenticatedEvent extends BiometricEvent {}

class IsBiometricEvent extends BiometricEvent{}
