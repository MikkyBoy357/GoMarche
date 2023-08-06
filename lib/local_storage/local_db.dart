import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../models/cart_item_model.dart';

class AppDataBaseService {
  bool _isInitialized = false;
  static const String dbName = 'foodBox';
  static Future<void> startService() async {
    Directory document = await getApplicationDocumentsDirectory();
    Hive.init(document.path);
    Hive.registerAdapter(CartItemModelAdapter());
    // Hive.registerAdapter(DeliveryStatusAdapter());
    await Hive.openBox<CartItemModel>('cartBox');
  }

  Future<void> init() async {
    try {
      await Hive.openBox<CartItemModel>(dbName);
      _isInitialized = true;
    } catch (e) {
      _isInitialized = false;
    }
  }

  List<CartItemModel> getMikeList() {
    return Hive.box<CartItemModel>('cartBox').values.toList();
  }

  Future<void> ensureInitialized() async {
    if (!_isInitialized) {
      await init();
    }
  }

  Future<void> closeDB() async {
    await Hive.close();
  }

  static Future<void> clearDB() async {
    await Hive.box(dbName).clear();
  }
}
