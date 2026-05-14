import 'package:flutter/material.dart';

void main() {
  runApp(const FoodDeliveryApp());
}

class FoodDeliveryApp extends StatelessWidget {
  const FoodDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Доставка Еды',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class FoodItem {
  final String name;
  final String price;
  final IconData icon;

  FoodItem(this.name, this.price, this.icon);
}

final List<FoodItem> menuItems = [
  FoodItem('Бургер Классика', '450 ₽', Icons.lunch_dining),
  FoodItem('Пицца Маргарита', '650 ₽', Icons.local_pizza),
  FoodItem('Суши Сет', '1200 ₽', Icons.set_meal),
  FoodItem('Кофе Капучино', '150 ₽', Icons.coffee),
  FoodItem('Салат Цезарь', '350 ₽', Icons.restaurant),
  FoodItem('Картофель Фри', '120 ₽', Icons.fastfood),
  FoodItem('Стейк из говядины', '950 ₽', Icons.room_service),
  FoodItem('Десерт Павлова', '250 ₽', Icons.cake),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return buildMobileLayout();
        }
        else {
          return buildDesktopLayout();
        }
      },
    );
  }

  Widget buildMobileLayout() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Меню доставки'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: buildGrid(crossAxisCount: 2),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Меню'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Корзина'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }

  Widget buildDesktopLayout() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Delivery - Desktop View'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) => setState(() => _selectedIndex = index),
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.menu_book), label: Text('Меню')),
              NavigationRailDestination(icon: Icon(Icons.shopping_cart), label: Text('Корзина')),
              NavigationRailDestination(icon: Icon(Icons.person), label: Text('Профиль')),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: buildGrid(crossAxisCount: 4),
          ),
        ],
      ),
    );
  }

  Widget buildGrid({required int crossAxisCount}) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return Card(
          elevation: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, size: 64, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 16),
              Text(
                item.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                item.price,
                style: TextStyle(color: Colors.grey[700], fontSize: 14),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {},
                child: const Text('В корзину'),
              )
            ],
          ),
        );
      },
    );
  }
}