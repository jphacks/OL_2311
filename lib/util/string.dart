import 'dart:math';

class StringUtils {
  static String generateRandomString(int length) {
    const characters = '0123456789ABCDEF';
    final random = Random();
    final charList = List.generate(length, (index) {
      return characters[random.nextInt(characters.length)];
    });
    return charList.join();
  }
}
