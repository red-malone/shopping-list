import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_items.dart';

class GroceryItems extends StatefulWidget {
  const GroceryItems({super.key});

  @override
  State<GroceryItems> createState() => _GroceryItemsState();
}

class _GroceryItemsState extends State<GroceryItems> {
  final List<GroceryItem> _groceryItem = [];

  void _nav() async {
    final newitem = await Navigator.of(context).push<GroceryItem>(
        MaterialPageRoute(builder: (context) => const NewItem()));

    if (newitem == null) {
      return;
    }
    setState(() {
      _groceryItem.add(newitem);
    });
  }

  void _removeitem(GroceryItem item) {
    setState(() {
      _groceryItem.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text("No Items , broke to buy"),
    );

    if (_groceryItem.isNotEmpty) {
      content = ListView.builder(
          itemCount: _groceryItem.length,
          itemBuilder: (context, index) {
            return Dismissible(
              onDismissed: (direction) {
                _removeitem(_groceryItem[index]);
              },
              key: ValueKey(_groceryItem[index].id),
              child: ListTile(
                title: Text(_groceryItem[index].name),
                subtitle: Text(_groceryItem[index].quantity.toString()),
                leading: CircleAvatar(
                  backgroundColor: _groceryItem[index].category.color,
                ),
              ),
            );
          });
    }
    return Scaffold(
      appBar: AppBar(
        title:const Text("Grocery List"),
        actions: [IconButton(onPressed: _nav, icon: Icon(Icons.add))],
      ),
      body: content,
    );
  }
}
