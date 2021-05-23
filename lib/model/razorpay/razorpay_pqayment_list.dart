// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

class PaymentModel {
  PaymentModel({
    this.entity,
    this.count,
    this.items,
  });

  String entity;
  int count;
  List<PaymentItem> items;

  factory PaymentModel.fromRawJson(String str) => PaymentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    entity: json["entity"],
    count: json["count"],
    items: List<PaymentItem>.from(json["items"].map((x) => PaymentItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "entity": entity,
    "count": count,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class PaymentItem {
  PaymentItem({
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
  String refundStatus;
  bool captured;
  String description;
  dynamic cardId;
  String bank;
  dynamic wallet;
  String vpa;
  String email;
  String contact;
  List<dynamic> notes;
  int fee;
  int tax;
  dynamic errorCode;
  dynamic errorDescription;
  dynamic errorSource;
  dynamic errorStep;
  dynamic errorReason;
  AcquirerData acquirerData;
  int createdAt;

  factory PaymentItem.fromRawJson(String str) => PaymentItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentItem.fromJson(Map<String, dynamic> json) => PaymentItem(
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
    refundStatus: json["refund_status"] == null ? null : json["refund_status"],
    captured: json["captured"],
    description: json["description"],
    cardId: json["card_id"],
    bank: json["bank"] == null ? null : json["bank"],
    wallet: json["wallet"],
    vpa: json["vpa"] == null ? null : json["vpa"],
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
    "refund_status": refundStatus == null ? null : refundStatus,
    "captured": captured,
    "description": description,
    "card_id": cardId,
    "bank": bank == null ? null : bank,
    "wallet": wallet,
    "vpa": vpa == null ? null : vpa,
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
    this.bankTransactionId,
  });

  String rrn;
  String upiTransactionId;
  String bankTransactionId;

  factory AcquirerData.fromRawJson(String str) => AcquirerData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AcquirerData.fromJson(Map<String, dynamic> json) => AcquirerData(
    rrn: json["rrn"] == null ? null : json["rrn"],
    upiTransactionId: json["upi_transaction_id"] == null ? null : json["upi_transaction_id"],
    bankTransactionId: json["bank_transaction_id"] == null ? null : json["bank_transaction_id"],
  );

  Map<String, dynamic> toJson() => {
    "rrn": rrn == null ? null : rrn,
    "upi_transaction_id": upiTransactionId == null ? null : upiTransactionId,
    "bank_transaction_id": bankTransactionId == null ? null : bankTransactionId,
  };
}
