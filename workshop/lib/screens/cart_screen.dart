import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'order_success_screen.dart';

// ── TODO STEP 4: import Hive ────────────────────────────────
// import 'package:hive_flutter/hive_flutter.dart';
// import '../models/cart_item.dart';
// import '../models/order.dart';

class CartScreen extends StatelessWidget {
  final void Function(Map<String, dynamic> order)? onOrderComplete;

  const CartScreen({super.key, this.onOrderComplete});

  // Example menu items that can be added to cart
  static const List<Map<String, dynamic>> _menu = [
    {'name': 'Mango Smoothie', 'price': 80.0, 'emoji': '🥭'},
    {'name': 'Berry Blast', 'price': 85.0, 'emoji': '🍓'},
    {'name': 'Green Detox', 'price': 75.0, 'emoji': '🥦'},
    {'name': 'Banana Shake', 'price': 70.0, 'emoji': '🍌'},
    {'name': 'Passion Fruit', 'price': 90.0, 'emoji': '🌸'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAF7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        title: const Text(
          '🍹 Hive Workshop Cart',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: const [],
      ),
      body: Column(
        children: [
          // ── Menu chips ───────────────────────────────────
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add menu:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: _menu
                      .map((m) => _MenuChip(
                            emoji: m['emoji'],
                            name: m['name'],
                            price: m['price'],
                            onTap: () => context
                                .read<CartProvider>()
                                .addItem(m['name'], m['price']),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // ── Cart list ─────────────────────────────────────
          Expanded(
            child: Consumer<CartProvider>(
              builder: (context, cart, _) {
                // TODO STEP 4: Change to use ValueListenableBuilder instead of Consumer
                // ValueListenableBuilder(
                //   valueListenable: Hive.box<CartItem>('cart').listenable(),
                //   builder: (context, Box<CartItem> box, _) {
                //     final items = box.values.toList();

                if (cart.items.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('🛒', style: TextStyle(fontSize: 64)),
                        SizedBox(height: 12),
                        Text(
                          'Cart is empty',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Tap menu buttons above to add items',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cart.items.length,
                  itemBuilder: (context, i) {
                    final item = cart.items[i];
                    return _CartItemCard(
                      name: item.name,
                      price: item.price,
                      quantity: item.quantity,
                      onIncrement: () => cart.increment(i),
                      onDecrement: () => cart.decrement(i),
                      onDelete: () => cart.removeAt(i),
                    );
                  },
                );
              },
            ),
          ),

          // ── Total panel ───────────────────────────────────
          Consumer<CartProvider>(
            builder: (context, cart, _) => _TotalPanel(
              total: cart.total,
              onOrderComplete: onOrderComplete,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Menu chip ─────────────────────────────────────────────────
class _MenuChip extends StatelessWidget {
  final String emoji, name;
  final double price;
  final VoidCallback onTap;
  const _MenuChip(
      {required this.emoji,
      required this.name,
      required this.price,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFE8F5E9),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF4CAF50), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 6),
            Text(name,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            const SizedBox(width: 4),
            Text('฿${price.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

// ── Cart item card ────────────────────────────────────────────
class _CartItemCard extends StatelessWidget {
  final String name;
  final double price;
  final int quantity;
  final VoidCallback onIncrement, onDecrement, onDelete;

  const _CartItemCard({
    required this.name,
    required this.price,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            // emoji box
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12)),
              child: const Center(
                  child: Text('🍹', style: TextStyle(fontSize: 24))),
            ),
            const SizedBox(width: 12),
            // name + price
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text('฿${price.toStringAsFixed(0)} each',
                      style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            // qty controls
            Row(
              children: [
                _QtyBtn(
                    icon: Icons.remove,
                    onTap: onDecrement,
                    color: Colors.grey.shade200,
                    iconColor: Colors.black87),
                SizedBox(
                  width: 32,
                  child: Text('$quantity',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                _QtyBtn(
                    icon: Icons.add,
                    onTap: onIncrement,
                    color: const Color(0xFF4CAF50),
                    iconColor: Colors.white),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onDelete,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8)),
                    child: Icon(Icons.delete_outline,
                        size: 16, color: Colors.red.shade400),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QtyBtn extends StatelessWidget {
  final IconData icon;
  final Color color, iconColor;
  final VoidCallback onTap;
  const _QtyBtn(
      {required this.icon,
      required this.color,
      required this.iconColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(7)),
        child: Icon(icon, size: 14, color: iconColor),
      ),
    );
  }
}

// ── Total panel ───────────────────────────────────────────────
class _TotalPanel extends StatelessWidget {
  final double total;
  final void Function(Map<String, dynamic> order)? onOrderComplete;

  const _TotalPanel({required this.total, this.onOrderComplete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, -3))
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Total',
                  style: TextStyle(color: Colors.grey, fontSize: 13)),
              // TODO STEP 5: Calculate total from box.values instead
              Text(
                '฿${total.toStringAsFixed(0)}',
                style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32)),
              ),
            ],
          ),
          ElevatedButton.icon(
            onPressed: total > 0
                ? () {
                    // Get current cart info
                    final cartProvider = context.read<CartProvider>();
                    final itemCount = cartProvider.items.length;

                    // Create order data for demo history
                    final orderData = {
                      'id': DateTime.now().millisecondsSinceEpoch.toString(),
                      'date': DateTime.now(),
                      'total': total,
                      'itemCount': itemCount,
                      'itemNames': cartProvider.items.map((item) => item.name).toList(),
                    };

                    // Navigate to success screen (works without Hive)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderSuccessScreen(
                          total: total,
                          itemCount: itemCount,
                          onBackToCart: () {
                            // Clear cart when returning (demo mode)
                            cartProvider.clearCart();
                            Navigator.pop(context);
                          },
                          onViewHistory: () {
                            // Save order and clear cart (demo mode)
                            cartProvider.clearCart();
                            onOrderComplete?.call(orderData);
                            // Pop and let parent switch tab
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  }
                : null,
            icon: const Icon(Icons.shopping_bag_outlined),
            label: const Text('Checkout'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ],
      ),
    );
  }
}
