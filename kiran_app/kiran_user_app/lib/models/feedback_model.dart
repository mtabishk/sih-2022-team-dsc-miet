class FeedbackModel {
  FeedbackModel({required this.uid, required this.data});
  final String uid;
  final String data;

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'data': data,
    };
  }
}
