import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptDataService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> encryptAndSave(String password, String data) async {
    // Generate a key from the password
    final key = _generateKey(password);

    // Encrypt the data
    final encryptedData = _encryptData(data, key);

    // Save the encrypted data
    await _storage.write(key: 'encrypted_data', value: encryptedData);
  }

  Future<String?> decrypt(String password) async {
    // Retrieve the encrypted data
    final encryptedData = await _storage.read(key: 'encrypted_data');

    if (encryptedData == null) return null;

    // Generate a key from the password
    final key = _generateKey(password);

    // Decrypt the data
    final decryptedData = _decryptData(encryptedData, key);

    return decryptedData;
  }

  static String _generateKey(String password) {
    final keyBytes = utf8.encode(password);
    return sha256.convert(keyBytes).toString();
  }

  static String _encryptData(String data, String key) {
    // final bytes = utf8.encode(data);
    // final encryptedBytes = AES(Key.fromUtf8(key), AESMode.ecb).encrypt(bytes);
    final myKey = encrypt.Key.fromUtf8(key);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(myKey));
    final encrypted = encrypter.encrypt(data, iv: iv);
    final encryptedBytes = encrypted.bytes;
    return base64Encode(encryptedBytes);
  }

  static String _decryptData(String encryptedData, String key) {
    final encryptedBytes = base64Decode(encryptedData);
    final myKey = encrypt.Key.fromUtf8(key);
    final encrypter = encrypt.Encrypter(encrypt.AES(myKey));
    final iv = encrypt.IV.fromLength(16);
    final encrypted = encrypter.encrypt(encryptedData, iv: iv);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    final decryptedBytes =
        AES(Key.fromUtf8(key),).decrypt(encrypted);
    return utf8.decode(decryptedBytes);
  }
}




//   String encrypt(String data, String password) {
//   final key = _generateKey(password);
//   // final encrypter = pointy.AESFastEngine()
//   //     ..init(true, pointy.KeyParameter(key.sublist(0, 16)));
//   final encrypter = 
//   final encrypted = _processData(encrypter, utf8.encode(data));
//   return base64.encode(encrypted);
// }

// List<int> _generateKey(String password) {
//   final salt = utf8.encode('some_salt_here');
//   final pbkdf2 = pointy.PBKDF2KeyDerivator(pointy.HMac(pointy.SHA1Digest(), 64))
//     ..init(pointy.Pbkdf2Parameters(salt, 1000, 16));
//   return pbkdf2.process(utf8.encode(password));
// }

// List<int> _processData(pointy.BlockCipher cipher, List<int> data) {
//   final paddedData = pointy.PKCS7Padding().pad(data);
//   return cipher.process(paddedData);
// }

  // Future<void> saveData(String key, String data, String password) async {
  //   final keyBytes = utf8.encode(password);
  //   final iv = encrypt.IV.fromLength(16);
  //   final encrypter = encrypt.Encrypter(
  //       encrypt.AES(encrypt.Key.fromUtf8(password), mode: encrypt.AESMode.cbc));
  //   final encrypted = encrypter.encrypt(data, iv: iv);
  //   final encryptedData = encrypted.base64;

  //   await _storage.write(key: key, value: encryptedData);
  // }

  // Future<String?> returnData(String key, String password) async {
  //   final encryptedData = await _storage.read(key: key);

  //   if (encryptedData == null) return null;

  //   final keyBytes = utf8.encode(password);
  //   final iv = encrypt.IV.fromLength(16);
  //   final encrypter = encrypt.Encrypter(
  //       encrypt.AES(encrypt.Key.fromUtf8(password), mode: encrypt.AESMode.cbc));
  //   final decrypted = encrypter.decrypt64(encryptedData, iv: iv);

  //   return decrypted;
  // }
