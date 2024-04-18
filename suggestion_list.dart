import 'package:flutter/material.dart';
import 'package:socproject/pages/home_card.dart';
import 'package:socproject/pages/items_model.dart';
import 'package:socproject/pages/item_details.dart';

class SuggestionList extends StatefulWidget {
  final String? title;
  final List<Item> items;

  const SuggestionList(this.title, this.items, {Key? key}) : super(key: key);

  @override
  State<SuggestionList> createState() => _SuggestionListState();
}

class _SuggestionListState extends State<SuggestionList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Container(
            height: 340.0,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.items.length,
              itemBuilder: (context, index) => ItemCard(
                widget.items[index],
                onTap: () {
                  // Handle tap event for each item card
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemDetailsScreen(item: widget.items[index]),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
