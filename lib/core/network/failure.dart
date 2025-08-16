import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

enum FailureType { network, timeout, unauthorized, server, cancel, unknown }

@freezed
abstract class AppFailure with _$AppFailure implements Exception {
  const factory AppFailure(FailureType type, {String? message, int? status}) =
      _AppFailure;
}
