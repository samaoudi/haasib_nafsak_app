import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import '../models/daily_record.dart';

class StorageService {
  static const String _recordsKey = 'daily_records';
  static const String _encryptionKeyKey = 'encryption_key';
  
  // تخزين آمن للمفاتيح
  static final _secureStorage = FlutterSecureStorage();
  
  // إنشاء أو استرجاع مفتاح التشفير
  static Future<String> _getEncryptionKey() async {
    String? key = await _secureStorage.read(key: _encryptionKeyKey);
    
    if (key == null) {
      // إنشاء مفتاح جديد إذا لم يكن موجوداً
      final random = encrypt.Key.fromSecureRandom(32);
      key = base64Encode(random.bytes);
      await _secureStorage.write(key: _encryptionKeyKey, value: key);
    }
    
    return key;
  }
  
  // تشفير البيانات
  static Future<String> _encryptData(String data) async {
    final key = encrypt.Key.fromBase64(await _getEncryptionKey());
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    
    return encrypter.encrypt(data, iv: iv).base64;
  }
  
  // فك تشفير البيانات
  static Future<String> _decryptData(String encryptedData) async {
    try {
      final key = encrypt.Key.fromBase64(await _getEncryptionKey());
      final iv = encrypt.IV.fromLength(16);
      final encrypter = encrypt.Encrypter(encrypt.AES(key));
      
      return encrypter.decrypt64(encryptedData, iv: iv);
    } catch (e) {
      // في حالة حدوث خطأ في فك التشفير
      return '[]';
    }
  }
  
  // حفظ سجلات المستخدم اليومية
  static Future<bool> saveDailyRecords(List<DailyRecord> records) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // تحويل السجلات إلى JSON
      final recordsJson = jsonEncode(records.map((r) => r.toJson()).toList());
      
      // تشفير البيانات
      final encryptedData = await _encryptData(recordsJson);
      
      // حفظ البيانات المشفرة
      return await prefs.setString(_recordsKey, encryptedData);
    } catch (e) {
      print('Error saving records: $e');
      return false;
    }
  }
  
  // استرجاع سجلات المستخدم اليومية
  static Future<List<DailyRecord>> getDailyRecords() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // استرجاع البيانات المشفرة
      final encryptedData = prefs.getString(_recordsKey);
      
      if (encryptedData == null) {
        return [];
      }
      
      // فك تشفير البيانات
      final recordsJson = await _decryptData(encryptedData);
      
      // تحويل JSON إلى كائنات
      final List<dynamic> recordsList = jsonDecode(recordsJson);
      
      return recordsList.map((json) => DailyRecord.fromJson(json)).toList();
    } catch (e) {
      print('Error loading records: $e');
      return [];
    }
  }
  
  // حفظ سجل يومي جديد
  static Future<bool> saveDailyRecord(DailyRecord record) async {
    try {
      // استرجاع السجلات الحالية
      final records = await getDailyRecords();
      
      // البحث عن سجل بنفس التاريخ واستبداله إذا وجد
      final index = records.indexWhere((r) => 
        r.date.year == record.date.year && 
        r.date.month == record.date.month && 
        r.date.day == record.date.day
      );
      
      if (index >= 0) {
        records[index] = record;
      } else {
        records.add(record);
      }
      
      // حفظ السجلات المحدثة
      return await saveDailyRecords(records);
    } catch (e) {
      print('Error saving record: $e');
      return false;
    }
  }
  
  // حذف جميع البيانات (للاختبار)
  static Future<bool> clearAllData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_recordsKey);
      return true;
    } catch (e) {
      print('Error clearing data: $e');
      return false;
    }
  }
  
  // إنشاء نسخة احتياطية من البيانات
  static Future<String?> createBackup() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encryptedData = prefs.getString(_recordsKey);
      
      if (encryptedData == null) {
        return null;
      }
      
      // إرجاع البيانات المشفرة كنسخة احتياطية
      return encryptedData;
    } catch (e) {
      print('Error creating backup: $e');
      return null;
    }
  }
  
  // استعادة البيانات من نسخة احتياطية
  static Future<bool> restoreBackup(String backupData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // حفظ البيانات المشفرة من النسخة الاحتياطية
      return await prefs.setString(_recordsKey, backupData);
    } catch (e) {
      print('Error restoring backup: $e');
      return false;
    }
  }
}
