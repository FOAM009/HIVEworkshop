import 'package:flutter/material.dart';

// ── Order Success Screen ───────────────────────────────────────────────
// Works WITHOUT Hive - just displays order confirmation
//
// After adding Hive, this will be called from CartScreen with saved order data

class OrderSuccessScreen extends StatelessWidget {
  final double total;
  final int itemCount;
  final VoidCallback onBackToCart;
  final VoidCallback onViewHistory;

  const OrderSuccessScreen({
    super.key,
    required this.total,
    required this.itemCount,
    required this.onBackToCart,
    required this.onViewHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAF7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: onBackToCart,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success animation
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),

              // Success message
              const Text(
                'Order Completed!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(height: 12),

              Text(
                'Thank you for your order',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 32),

              // Order summary card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _SummaryRow(
                      label: 'Items',
                      value: '$itemCount ${itemCount == 1 ? 'item' : 'items'}',
                    ),
                    const Divider(height: 20),
                    _SummaryRow(
                      label: 'Total',
                      value: '฿${total.toStringAsFixed(0)}',
                      isTotal: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Info banner (shows this is demo mode)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 16, color: Colors.orange.shade700),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Demo mode: Order not saved. Add Hive to enable order history.',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.orange.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Action buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onViewHistory,
                  icon: const Icon(Icons.history),
                  label: const Text('View Order History'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: onBackToCart,
                  icon: const Icon(Icons.shopping_cart_outlined),
                  label: const Text('Back to Cart'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF2E7D32),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Color(0xFF2E7D32)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            color: isTotal ? Colors.black87 : Colors.grey.shade600,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            color: Color(0xFF2E7D32),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
