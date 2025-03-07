import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String id;
  final String userId;
  final String userName;
  final String userImage;
  final String productId;
  final double rating;
  final String comment;
  final DateTime createdAt;
  String? companyResponse;
  DateTime? companyResponseDate;

  ReviewModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.productId,
    required this.rating,
    required this.comment,
    required this.createdAt,
    this.companyResponse,
    this.companyResponseDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
      'productId': productId,
      'rating': rating,
      'comment': comment,
      'createdAt': Timestamp.fromDate(createdAt),
      'companyResponse': companyResponse,
      'companyResponseDate': companyResponseDate != null
          ? Timestamp.fromDate(companyResponseDate!)
          : null,
    };
  }

  factory ReviewModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ReviewModel(
      id: snapshot.id,
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      userImage: data['userImage'] ?? '',
      productId: data['productId'] ?? '',
      rating: (data['rating'] ?? 0.0).toDouble(),
      comment: data['comment'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      companyResponse: data['companyResponse'],
      companyResponseDate: data['companyResponseDate'] != null
          ? (data['companyResponseDate'] as Timestamp).toDate()
          : null,
    );
  }
}
