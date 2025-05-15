
import 'package:shared_preferences/shared_preferences.dart';

class NotifyMePrefs {
  static const String prefKey = 'notifyMeProductIds';

  Future<void> add(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(prefKey) ?? [];
    if (!ids.contains(productId.toString())) {
      ids.add(productId.toString());
      await prefs.setStringList(prefKey, ids);
    }
  }

  Future<void> remove(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(prefKey) ?? [];
    if (ids.contains(productId.toString())) {
      ids.remove(productId.toString());
      await prefs.setStringList(prefKey, ids);
    }
  }

  Future<bool> contains(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(prefKey) ?? [];
    return ids.contains(productId.toString());
  }
}
