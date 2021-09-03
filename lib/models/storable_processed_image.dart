import 'package:hive/hive.dart';

part 'storable_processed_image.g.dart';

@HiveType(typeId : 1)
class StorableProcessedImage{
  @HiveField(0)
  final String path;
  @HiveField(1)
  final List<int> palette;

  StorableProcessedImage(this.path, this.palette);
}
