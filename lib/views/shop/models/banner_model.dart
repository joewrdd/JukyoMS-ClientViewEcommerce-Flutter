import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  String imageUrl;
  String id;
  final String targetScreen;
  final bool active;

  BannerModel(
      {required this.id,
      required this.imageUrl,
      required this.targetScreen,
      required this.active});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'ImageUrl': imageUrl,
      'TargetScreen': targetScreen,
      'Active': active,
    };
  }

  static BannerModel empty() =>
      BannerModel(id: '', imageUrl: '', targetScreen: '', active: false);

  factory BannerModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return BannerModel(
        id: document.id,
        imageUrl: data['ImageUrl'] ?? '',
        targetScreen: data['TargetScreen'] ?? '',
        active: data['Active'] ?? false,
      );
    } else {
      return BannerModel.empty();
    }
  }
}
