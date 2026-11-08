class UserComment {
  const UserComment({required this.author, required this.message, required this.date});
  final String author;
  final String message;
  final String date;
  Map<String,String> toJson() => {'author':author,'message':message,'date':date};
  factory UserComment.fromJson(Map<String,dynamic> json) => UserComment(author: json['author'] as String? ?? 'User',message:json['message'] as String? ?? '',date:json['date'] as String? ?? '');
}
