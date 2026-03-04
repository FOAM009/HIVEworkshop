import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'screens/main_screen.dart';

// ── TODO STEP 3: Add imports here ────────────────────────────────
// import 'package:hive_flutter/hive_flutter.dart';
// import 'models/cart_item.dart';

// ── BONUS: Uncomment after completing STEPs 1-5 ─────────────────────
// import 'models/order.dart';  // For order history feature

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ── TODO STEP 3: Add Hive init here ─────────────────────────────
  // await Hive.initFlutter();
  // Hive.registerAdapter(CartItemAdapter());
  // await Hive.openBox<CartItem>('cart');

  // ── BONUS: Uncomment after completing STEPs 1-5 ────────────────────
  // Hive.registerAdapter(OrderAdapter());
  // await Hive.openBox<Order>('orders');

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
