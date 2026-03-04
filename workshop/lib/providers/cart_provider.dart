import 'package:flutter/material.dart';

// ── Cart Provider ─────────────────────────────────────────────────────────
// 📦 STEP 4: Replace List with Hive Box → See PPTX_SLIDES.md

// TODO STEP 4: Add imports:
// import 'package:hive/hive.dart';
// import '../models/cart_item.dart';

// TODO STEP 4: Remove CartItemData class (use CartItem from models instead)

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
  // TODO STEP 4: Change to: late final Box<CartItem> _box;
  final List<CartItemData> _items = [];

  // TODO STEP 4: Add constructor:
  // CartProvider() { _box = Hive.box<CartItem>('cart'); }

  // TODO STEP 4: Change to: List<CartItem> get items => _box.values.toList();
  List<CartItemData> get items => List.unmodifiable(_items);

  // TODO STEP 4: Change to: _box.values.fold(0, (sum, CartItem item) => ...)
  double get total =>
      _items.fold(0, (sum, item) => sum + item.price * item.quantity);

  // TODO STEP 4: Use firstWhere + orElse + .save()
  void addItem(String name, double price) {
    // ── Replace with ────────────────────────────────────────────────────────
    // final existing = _box.values.firstWhere(
    //   (item) => item.name == name,
    //   orElse: () => CartItem(name: name, price: price, quantity: 0),
    // );
    // if (existing.quantity > 0) {
    //   existing.quantity++;
    //   existing.save();
    // } else {
    //   _box.add(CartItem(name: name, price: price, quantity: 1));
    // }
    // notifyListeners();
    final existing = _items.where((i) => i.name == name).firstOrNull;
    if (existing != null) {
      existing.quantity++;
    } else {
      _items.add(CartItemData(name: name, price: price, quantity: 1));
    }
    notifyListeners();
  }

  // TODO STEP 4: Use getAt(index) + .save()
  void increment(int index) {
    // ── Replace with ────────────────────────────────────────────────────────
    // final item = _box.getAt(index);
    // if (item != null) {
    //   item.quantity++;
    //   item.save();
    //   notifyListeners();
    // }
    _items[index].quantity++;
    notifyListeners();
  }

  // TODO STEP 4: Use getAt(index) + .save() or .delete()
  void decrement(int index) {
    // ── Replace with ────────────────────────────────────────────────────────
    // final item = _box.getAt(index);
    // if (item != null) {
    //   if (item.quantity > 1) {
    //     item.quantity--;
    //     item.save();
    //   } else {
    //     item.delete();
    //   }
    //   notifyListeners();
    // }
    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    } else {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  // TODO STEP 4: Change to: _box.deleteAt(index);
  void removeAt(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  // TODO STEP 4: Change to: _box.clear();
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
