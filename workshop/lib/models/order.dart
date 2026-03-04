// ── BONUS: Order Model ────────────────────────────────────────────────
// This file is prepared for the BONUS section (after completing STEPs 1-5)
//
// DO NOT UNCOMMENT until after:
// ✅ STEP 1: Hive dependencies added (pubspec.yaml)
// ✅ STEP 2: CartItem model created & adapter generated
// ✅ STEP 3: Hive initialized in main.dart
// ✅ STEP 4: CartProvider updated to use Hive
// ✅ STEP 5: CartScreen UI updated with ValueListenableBuilder
//
// Then to enable the BONUS feature:
// 1. Uncomment this entire file (remove /* */)
// 2. Uncomment import in main.dart
// 3. Uncomment the orders box initialization in main.dart
// 4. Run: dart run build_runner build
// 5. Uncomment checkout logic in cart_screen.dart to save orders
// 6. Uncomment order_history_screen.dart implementation

/*
import 'package:hive/hive.dart';

part 'order.g.dart';

@HiveType(typeId: 1)  // ← Different ID from CartItem (0)
class Order extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final double total;

  @HiveField(3)
  final int itemCount;

  @HiveField(4)
  final List<String> itemNames;

  Order({
    required this.id,
    required this.date,
    required this.total,
    required this.itemCount,
    required this.itemNames,
  });

  // Helper to create order from cart items
  factory Order.fromCart({
    required List<Map<String, dynamic>> cartItems,
    required double total,
  }) {
    return Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      total: total,
      itemCount: cartItems.length,
      itemNames: cartItems.map((item) => item['name'] as String).toList(),
    );
  }

  // Format date for display
  String get formattedDate {
    final hours = date.hour.toString().padLeft(2, '0');
    final minutes = date.minute.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;
    return '$hours:$minutes • $day/$month/$year';
  }
}
*/
