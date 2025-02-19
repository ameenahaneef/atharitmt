import 'package:hive/hive.dart';

part 'products_model.g.dart';
@HiveType(typeId: 0)
class ScannedProduct extends HiveObject {
  @HiveField(0)
  final String expiryDate;

  @HiveField(1)
  final String status;

  @HiveField(2)
  final String imagePath; 

 
  ScannedProduct({required this.expiryDate, required this.status, required this.imagePath});
}
