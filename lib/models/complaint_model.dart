class ComplaintModel {
  String success;
  List<Data> data;

  ComplaintModel({
    required this.success,
    required this.data
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      success: json['success'],
      data: (json['data'] as List)
          .map((item) => Data.fromJson(item))
          .toList(),
    );
  }
}

class Data {
  int complaintId;
  int complaintMessage;
  List<String> complaintReply;

  Data({
    required this.complaintId,
    required this.complaintMessage,
    required this.complaintReply,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        complaintId: json['complaint_id'],
        complaintMessage: json['complaint_message'],
        complaintReply: json['complaint_reply']
    );
  }
}