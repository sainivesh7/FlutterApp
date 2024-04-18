import 'package:flutter/material.dart';

class SelectCategory extends StatelessWidget {
  final void Function(String category) onCategorySelected;

  const SelectCategory({
    required this.onCategorySelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategoryButton(context, "House"),
          _buildCategoryButton(context, "Villa"),
          _buildCategoryButton(context, "Apartment"),
          _buildCategoryButton(context, "Land"),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context, String category) {
    return Container(
      margin: EdgeInsets.all(0.0),
      padding: EdgeInsets.all(8.0),
      width: 120.0,
      height: 80.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade100),
        color: Colors.white,
      ),
      child: InkWell(
        onTap: () => onCategorySelected(category),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              _getIconForCategory(category),
              size: 32.0,
              color: Colors.blueAccent,
            ),
            Text("$category"),
          ],
        ),
      ),
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category.toLowerCase()) {
      case "house":
        return Icons.house_rounded;
      case "villa":
        return Icons.villa_rounded;
      case "apartment":
        return Icons.apartment_rounded;
      case "land":
        return Icons.crop_landscape;
      default:
        return Icons.category;
    }
  }
}