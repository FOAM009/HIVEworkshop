import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'screens/main_screen.dart';

// ── TODO STEP 3: Add imports here ────────────────────────────────
// import 'package:hive_flutter/hive_flutter.dart';
// import 'models/cart_item.dart';

// ── 📦 STEP 7: Uncomment after completing STEPs 1-6 ───────────────
// This enables the Orders box for order history persistence
// import 'models/order.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ── TODO STEP 3: Add Hive init here ─────────────────────────────
  // Initialize Hive and register CartItem adapter (STEP 3)
  // await Hive.initFlutter();
  // Hive.registerAdapter(CartItemAdapter());
  // await Hive.openBox<CartItem>('cart');

  // ── 📦 STEP 7: Initialize Orders Box ─────────────────────────────
  // After enabling order.dart and running build_runner:
  // Hive.registerAdapter(OrderAdapter());
  // await Hive.openBox<Order>('orders');
  //
  // 🎯 This creates a SECOND box for order history
  //    - 'cart' box: Current items (cleared after checkout)
  //    - 'orders' box: Past orders (persists forever)

  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Workshop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D32)),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
