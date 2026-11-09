class Usercomment {
  String commenter;
  String message;

  Usercomment({required this.commenter, required this.message});

  Map<String, dynamic> toJson() {
    return {'commenter': commenter, 'message': message};
  }

  factory Usercomment.fromJson(Map<String, dynamic> data) {
    return Usercomment(
      commenter: data['commenter']?.toString() ?? '',
      message: data['message']?.toString() ?? '',
    );
  }
}
