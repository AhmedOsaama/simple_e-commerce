import 'package:hive/hive.dart';

class HiveHelper{
  static late Box cartBox;

  static Future<void> initHiveBox() async {
    await Hive.openBox("cart_box");
    cartBox = Hive.box("cart_box");
  }

  static Future<void> storeProductInCart(Map cartItemMap) async {
    List cartItems = getStoredCartItems();
    cartItems.add(cartItemMap);
   await cartBox.put("cart_items", cartItems);
  }

  static Future<void> updateProductQuantity({required int newQty, required int id}) async {
    List cartItems = getStoredCartItems();
    var item = cartItems.firstWhere((element) => element['id'] == id);
    item['qty'] = newQty;
    await cartBox.put("cart_items", cartItems);
  }

  static Future<void> deleteStoredProductInCart(int id) async {
    List cartItems = getStoredCartItems();
    cartItems.removeWhere((element) => element['id'] == id);
   await cartBox.put("cart_items", cartItems);
  }

  static List getStoredCartItems(){
    return cartBox.get("cart_items") ?? [];
  }


}