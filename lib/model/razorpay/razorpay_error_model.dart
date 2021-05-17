// To parse this JSON data, do
//
//     final razorPayErrorModel = razorPayErrorModelFromJson(jsonString);

import 'dart:convert';

RazorPayErrorModel razorPayErrorModelFromJson(String str) => RazorPayErrorModel.fromJson(json.decode(str));

String razorPayErrorModelToJson(RazorPayErrorModel data) => json.encode(data.toJson());

class RazorPayErrorModel {
  RazorPayErrorModel({
    this.error,
  });

  Error error;

  factory RazorPayErrorModel.fromJson(Map<String, dynamic> json) => RazorPayErrorModel(
    error: Error.fromJson(json["error"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error.toJson(),
  };
}

class Error {
  Error({
    this.code,
    this.description,
    this.source,
    this.step,
    this.reason,
    this.metadata,
    this.field,
  });

  String code;
  String description;
  String source;
  String step;
  String reason;
  Metadata metadata;
  String field;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    code: json["code"],
    description: json["description"],
    source: json["source"],
    step: json["step"],
    reason: json["reason"],
    metadata: Metadata.fromJson(json["metadata"]),
    field: json["field"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "description": description,
    "source": source,
    "step": step,
    "reason": reason,
    "metadata": metadata.toJson(),
    "field": field,
  };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
  );

  Map<String, dynamic> toJson() => {
  };
}
