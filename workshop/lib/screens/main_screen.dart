import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'cart_screen.dart';
import 'order_history_screen.dart';

// ── Main Screen with Bottom Navigation ───────────────────────────────
// Cart = Current items, History = Past orders

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // TODO STEP 8: Remove demoOrders list and addDemoOrder method
  final List<Map<String, dynamic>> _demoOrders = [];

  void addDemoOrder(Map<String, dynamic> order) {
    setState(() {
      _demoOrders.insert(0, order); // Add to beginning (newest first)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          CartScreen(
            onOrderComplete: (order) {
              // TODO STEP 8: Remove addDemoOrder() call - order already saved to Hive
              addDemoOrder(order);
              setState(() {
                _currentIndex = 1;
              });
            },
          ),
          // TODO STEP 8: Change to: const OrderHistoryScreen()
          OrderHistoryScreen(
            demoOrders: _demoOrders,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF2E7D32),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'History',
          ),
        ],
      ),
    );
  }
}
