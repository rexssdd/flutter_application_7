
class Usercomment {
  String commenter;
  String message;
  DateTime? createdAt;
  String? profileImage;

  Usercomment({
    required this.commenter,
    required this.message,
    this.createdAt,
    this.profileImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'commenter': commenter,
      'message': message,
      'createdAt': createdAt?.toIso8601String(),
      'profileImage': profileImage,
    };
  }

  factory Usercomment.fromJson(Map<String, dynamic> data) {
    return Usercomment(
      commenter: data['commenter']?.toString() ?? '',
      message: data['message']?.toString() ?? '',
      createdAt: DateTime.tryParse(
        data['createdAt']?.toString() ?? '',
      ),
      profileImage: data['profileImage']?.toString(),
    );
  }
}
