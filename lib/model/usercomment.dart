class Usercomment {
  String commenter;
  String message;
  DateTime? createdAt;

  Usercomment({required this.commenter, required this.message, this.createdAt});

  Map<String, dynamic> toJson() {
    return {
      'commenter': commenter,
      'message': message,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory Usercomment.fromJson(Map<String, dynamic> data) {
    return Usercomment(
      commenter: data['commenter']?.toString() ?? '',
      message: data['message']?.toString() ?? '',
      createdAt: DateTime.tryParse(data['createdAt']?.toString() ?? ''),
    );
  }
}
