import 'package:hive/hive.dart';

part 'person.g.dart';

@HiveType(typeId: 1)
class Person {
  Person({required this.name,required this.exp, required this.picture, required this.amount,required this.type});
  @HiveField(0)
  String name;

  @HiveField(1)
  String exp;

  @HiveField(2)
  String picture;

  @HiveField(3)
  int amount;

  @HiveField(4)
  String type;
}