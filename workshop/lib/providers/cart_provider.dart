import 'package:flutter/material.dart';

// ── Item data stored in memory ──────────────────────────────────────
// ⚠️  Currently using List → data lost on restart!
// TODO STEP 4: Change to use Hive box instead of List

class CartItemData {
  final String name;
  final double price;
  int quantity;

  CartItemData({
    required this.name,
    required this.price,
    required this.quantity,
  });
}

class CartProvider extends ChangeNotifier {
  // ⚠️  Regular List — data lost every restart!
  final List<CartItemData> _items = [];

  List<CartItemData> get items => List.unmodifiable(_items);

  double get total =>
      _items.fold(0, (sum, item) => sum + item.price * item.quantity);

  void addItem(String name, double price) {
    final existing = _items.where((i) => i.name == name).firstOrNull;
    if (existing != null) {
      existing.quantity++;
    } else {
      _items.add(CartItemData(name: name, price: price, quantity: 1));
    }
    notifyListeners();
  }

  void increment(int index) {
    _items[index].quantity++;
    notifyListeners();
  }

  void decrement(int index) {
    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    } else {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  void removeAt(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  // ── BONUS: Clear cart after checkout ────────────────────────
  // This will be used after order is saved to Hive
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
