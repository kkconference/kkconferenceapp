

// To parse this JSON data, do
//
//     final razorPayPaymentModel = razorPayPaymentModelFromJson(jsonString);

import 'dart:convert';

RazorPayPaymentModel razorPayPaymentModelFromJson(String str) => RazorPayPaymentModel.fromJson(json.decode(str));

String razorPayPaymentModelToJson(RazorPayPaymentModel data) => json.encode(data.toJson());

class RazorPayPaymentModel {
  RazorPayPaymentModel({
    this.id,
    this.entity,
    this.amount,
    this.currency,
    this.status,
    this.orderId,
    this.invoiceId,
    this.international,
    this.method,
    this.amountRefunded,
    this.refundStatus,
    this.captured,
    this.description,
    this.cardId,
    this.bank,
    this.wallet,
    this.vpa,
    this.email,
    this.contact,
    this.notes,
    this.fee,
    this.tax,
    this.errorCode,
    this.errorDescription,
    this.errorSource,
    this.errorStep,
    this.errorReason,
    this.acquirerData,
    this.createdAt,
  });

  String id;
  String entity;
  int amount;
  String currency;
  String status;
  dynamic orderId;
  dynamic invoiceId;
  bool international;
  String method;
  int amountRefunded;
  dynamic refundStatus;
  bool captured;
  String description;
  dynamic cardId;
  dynamic bank;
  dynamic wallet;
  String vpa;
  String email;
  String contact;
  List<dynamic> notes;
  dynamic fee;
  dynamic tax;
  dynamic errorCode;
  dynamic errorDescription;
  dynamic errorSource;
  dynamic errorStep;
  dynamic errorReason;
  AcquirerData acquirerData;
  int createdAt;

  factory RazorPayPaymentModel.fromJson(Map<String, dynamic> json) => RazorPayPaymentModel(
    id: json["id"],
    entity: json["entity"],
    amount: json["amount"],
    currency: json["currency"],
    status: json["status"],
    orderId: json["order_id"],
    invoiceId: json["invoice_id"],
    international: json["international"],
    method: json["method"],
    amountRefunded: json["amount_refunded"],
    refundStatus: json["refund_status"],
    captured: json["captured"],
    description: json["description"],
    cardId: json["card_id"],
    bank: json["bank"],
    wallet: json["wallet"],
    vpa: json["vpa"],
    email: json["email"],
    contact: json["contact"],
    notes: List<dynamic>.from(json["notes"].map((x) => x)),
    fee: json["fee"],
    tax: json["tax"],
    errorCode: json["error_code"],
    errorDescription: json["error_description"],
    errorSource: json["error_source"],
    errorStep: json["error_step"],
    errorReason: json["error_reason"],
    acquirerData: AcquirerData.fromJson(json["acquirer_data"]),
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "entity": entity,
    "amount": amount,
    "currency": currency,
    "status": status,
    "order_id": orderId,
    "invoice_id": invoiceId,
    "international": international,
    "method": method,
    "amount_refunded": amountRefunded,
    "refund_status": refundStatus,
    "captured": captured,
    "description": description,
    "card_id": cardId,
    "bank": bank,
    "wallet": wallet,
    "vpa": vpa,
    "email": email,
    "contact": contact,
    "notes": List<dynamic>.from(notes.map((x) => x)),
    "fee": fee,
    "tax": tax,
    "error_code": errorCode,
    "error_description": errorDescription,
    "error_source": errorSource,
    "error_step": errorStep,
    "error_reason": errorReason,
    "acquirer_data": acquirerData.toJson(),
    "created_at": createdAt,
  };
}

class AcquirerData {
  AcquirerData({
    this.rrn,
    this.upiTransactionId,
  });

  String rrn;
  String upiTransactionId;

  factory AcquirerData.fromJson(Map<String, dynamic> json) => AcquirerData(
    rrn: json["rrn"],
    upiTransactionId: json["upi_transaction_id"],
  );

  Map<String, dynamic> toJson() => {
    "rrn": rrn,
    "upi_transaction_id": upiTransactionId,
  };
}
