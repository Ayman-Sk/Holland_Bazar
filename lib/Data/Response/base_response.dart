import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseMapResponse<T> {
  int? status;
  String? message;
  final T? data;

  BaseMapResponse({this.status, this.data, this.message});

  factory BaseMapResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$BaseMapResponseFromJson(json, fromJsonT);
}

@JsonSerializable(genericArgumentFactories: true)
class BaseListResponse<T> {
  int? status;
  String? message;
  List<T>? data;

  BaseListResponse({this.status, this.data, this.message});

  factory BaseListResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$BaseListResponseFromJson(json, fromJsonT);
}
