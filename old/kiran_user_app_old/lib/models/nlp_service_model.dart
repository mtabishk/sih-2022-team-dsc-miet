import 'package:flutter/foundation.dart';

class NLPServiceModel {
  final String emotion;
  final double negative;
  final double positive;

  NLPServiceModel({
    required this.emotion,
    required this.negative,
    required this.positive,
  });

  factory NLPServiceModel.fromJson(Map<String, dynamic> json) {
    return NLPServiceModel(
      emotion: json['emotion'],
      negative: double.tryParse(json['negative']) ?? 0.0,
      positive: double.tryParse(json['positive']) ?? 0.0,
    );
  }
}
