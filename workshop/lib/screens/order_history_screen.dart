import 'package:flutter/material.dart';
// ── 📦 STEP 8: Import Hive ────────────────────────────────────────
// import 'package:hive_flutter/hive_flutter.dart';
// import '../models/order.dart';

// ── Order History Screen ────────────────────────────────────────────────
// ⚠️ CURRENT: Demo mode - orders lost on restart
// ✅ STEP 8: Read from Hive - orders persist forever
//
// See PPTX_SLIDES.md "STEP 8 (Part 2): Display Order History"

class OrderHistoryScreen extends StatelessWidget {
  // ❌ TODO STEP 8: Remove demoOrders parameter
  final List<Map<String, dynamic>> demoOrders;

  const OrderHistoryScreen({super.key, this.demoOrders = const []});

  @override
  Widget build(BuildContext context) {
    // ── 📦 STEP 8: Display Orders from Hive ────────────────────────────────
    // 1. Uncomment imports at top of file
    // 2. Remove demoOrders parameter (line 14)
    // 3. Replace body with ValueListenableBuilder (see PPTX_SLIDES.md)
    //
    // ValueListenableBuilder(
    //   valueListenable: Hive.box<Order>('orders').listenable(),
    //   builder: (context, Box<Order> box, _) {
    //     final orders = box.values.toList()
    //       ..sort((a, b) => b.date.compareTo(a.date));
    //
    //     if (orders.isEmpty) {
    //       return const Center(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Icon(Icons.receipt_long_outlined, size: 64, color: Colors.grey),
    //             SizedBox(height: 16),
    //             Text('No orders yet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    //             SizedBox(height: 8),
    //             Text('Complete your first order to see it here'),
    //           ],
    //         ),
    //       );
    //     }
    //
    //     return ListView.builder(
    //       padding: const EdgeInsets.all(16),
    //       itemCount: orders.length,
    //       itemBuilder: (context, i) {
    //         final order = orders[i];
    //         return _OrderCard(...);
    //       },
    //     );
    //   },
    // );

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAF7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        title: const Text(
          '📋 Order History',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // Demo indicator
          if (demoOrders.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange.shade400,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Demo',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
      body: demoOrders.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long_outlined,
                      size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No orders yet',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Complete your first order to see it here',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 24),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'Orders are saved in memory for demo.\nAdd Hive to make them persist!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: demoOrders.length,
              itemBuilder: (context, i) {
                final order = demoOrders[i];
                return _OrderCard(
                  id: order['id'].toString(),
                  date: order['date'] as DateTime,
                  total: (order['total'] as num).toDouble(),
                  itemCount: order['itemCount'] as int,
                  itemNames: List<String>.from(order['itemNames'] ?? []),
                );
              },
            ),
    );
  }
}

// ── Order Card Widget ───────────────────────────────────────────
class _OrderCard extends StatelessWidget {
  final String id;
  final DateTime date;
  final double total;
  final int itemCount;
  final List<String> itemNames;

  const _OrderCard({
    required this.id,
    required this.date,
    required this.total,
    required this.itemCount,
    required this.itemNames,
  });

  String get formattedDate {
    final hours = date.hour.toString().padLeft(2, '0');
    final minutes = date.minute.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;
    return '$hours:$minutes • $day/$month/$year';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: ID and Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #$id',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  formattedDate,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const Divider(height: 16),

            // Items
            if (itemNames.isNotEmpty) ...[
              Text(
                'Items:',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              ...itemNames.take(3).map((name) => Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 4),
                    child: Row(
                      children: [
                        Icon(Icons.circle,
                            size: 4, color: Colors.grey.shade400),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            name,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              if (itemNames.length > 3)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    '+${itemNames.length - 3} more',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              const SizedBox(height: 8),
            ],

            // Items count and total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.shopping_bag_outlined,
                        size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 6),
                    Text(
                      '$itemCount ${itemCount == 1 ? 'item' : 'items'}',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                Text(
                  '฿${total.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
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
