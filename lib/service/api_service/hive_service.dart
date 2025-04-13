import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newsarticle/constants/strings.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static const String _searchBoxName = Strings.searchBox;

  static final Box<String> _searchBox = Hive.box<String>(_searchBoxName);

  static Future<void> init() async {
    if (kIsWeb) {
      await Hive.initFlutter();
    } else {
      final Directory appDocumentsDir =
          await getApplicationDocumentsDirectory();
      Hive.init(appDocumentsDir.path);
    }

    try {
      // Hive.registerAdapter(SearchModelAdapter());
      List<int> generatedKey = [
        0,
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18,
        19,
        20,
        21,
        22,
        23,
        24,
        25,
        26,
        27,
        28,
        29,
        30,
        31
      ];
      String encryptionKeyString = base64UrlEncode(generatedKey);

      final encryptionKeyUint8List = base64Url.decode(encryptionKeyString);

      await _openEncryptedBox<String>(_searchBoxName, encryptionKeyUint8List);
    } catch (e) {
      debugPrint("Error in the hive init is $e");
    }
  }

  static Future<void> _openEncryptedBox<T>(
      String boxName, Uint8List encryptionKey) async {
    try {
      await Hive.openBox<T>(boxName,
          encryptionCipher: HiveAesCipher(encryptionKey));
    } catch (e) {
      debugPrint(
          "⚠️ Hive Box '$boxName' is corrupted: $e. Deleting and recreating...");
      await Hive.deleteBoxFromDisk(boxName);
      await Hive.openBox<T>(boxName,
          encryptionCipher: HiveAesCipher(encryptionKey));
    }
  }

  void storeSearchValues(String query) {
    final box = _searchBox;
    // check the duplicates if found no need to add in the storage
    if (!box.values.contains(query)) {
      print("Query is $query");
      box.put(DateTime.now().toIso8601String(), query);
      fetchStoredValues();
    }
  }

  fetchStoredValues(){
    final box = _searchBox;
    List values = box.values.toList();
    print("Value in fetch is $values");
    return values;
  }

  deleteFiveDaysOnce() {
    final box = _searchBox;
    final now = DateTime.now();
    final keysToDelete = box.keys;
    for (var key in keysToDelete) {
      final storedDate = DateTime.tryParse(key);
      if (storedDate != null && now.difference(storedDate!).inDays > 5) {
        box.delete(key);
      }
    }
  }

  Future<void> closeHive() async {
    //await Hive.close();
  }
}
