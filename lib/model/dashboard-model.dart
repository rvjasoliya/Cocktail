import 'package:json_annotation/json_annotation.dart';

import 'drinks-model.dart';

part 'dashboard-model.g.dart';

/*Autogenerated dashboardDataModelFromJson(String str) =>
    Autogenerated.fromJson(json.decode(str));

String dashboardDataModelToJson(Autogenerated data) =>
    json.encode(data.toJson());*/

@JsonSerializable()
class Autogenerated {
  List<Drinks>? drinks;

  Autogenerated({this.drinks});

  factory Autogenerated.fromJson(Map<String, dynamic> json) =>
      _$AutogeneratedFromJson(json);
  Map<String, dynamic> toJson() => _$AutogeneratedToJson(this);
}
