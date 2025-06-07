import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) =>
                const MyHomePage(title: 'Flutter Demo Home Page')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/logo.png', width: 180),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SalaSignage',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class Product {
  final String title;
  final String description;
  final String image;
  Product(
      {required this.title, required this.description, required this.image});
}

final List<Product> products = [
  Product(
    title: 'Lavie 500ml',
    description:
        'Nước khoáng Lavie chai 500ml, tinh khiết, tiện lợi cho mọi hoạt động.',
    image: 'assets/images/shopping.png',
  ),
  Product(
    title: 'Lavie 1.5L',
    description:
        'Nước khoáng Lavie chai 1.5L, phù hợp cho gia đình và văn phòng.',
    image: 'assets/images/shopping.png',
  ),
  Product(
    title: 'Lavie 350ml',
    description: 'Nước khoáng Lavie chai 350ml, nhỏ gọn, dễ mang theo.',
    image: 'assets/images/shopping.png',
  ),
  Product(
    title: 'Lavie 5L',
    description: 'Nước khoáng Lavie bình 5L, tiết kiệm cho nhu cầu lớn.',
    image: 'assets/images/shopping.png',
  ),
  Product(
    title: 'Lavie 19L',
    description: 'Nước khoáng Lavie bình 19L, dùng cho máy lọc nước.',
    image: 'assets/images/shopping.png',
  ),
];

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('SalaSignage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(product: product),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          product.image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 13, color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  Future<void> _openShopeeApp(BuildContext context) async {
    final uri = Uri.parse('https://shopee.vn/');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri,  mode: LaunchMode.externalApplication,);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không tìm thấy ứng dụng Shopee!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(product.image, width: 120, height: 120)),
            const SizedBox(height: 24),
            Text(product.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Text(product.description),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () => _openShopeeApp(context),
                child: const Text('Add to cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
