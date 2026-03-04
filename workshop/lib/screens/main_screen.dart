import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'cart_screen.dart';
import 'order_history_screen.dart';

// ── Main Screen with Bottom Navigation ───────────────────────────────
// Home = Cart, History = Order History
//
// Demo mode: Orders stored in memory only (lost on restart)
// After adding Hive: Orders will be persisted

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // ── Demo mode: In-memory order list (lost on restart) ─────────────
  // TODO BONUS: Remove this after adding Hive - will use Hive.box instead
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
              // Add to demo orders (in-memory)
              addDemoOrder(order);
              // Switch to history tab
              setState(() {
                _currentIndex = 1;
              });
            },
          ),
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
