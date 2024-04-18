import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySearch extends StatefulWidget {
  final ValueChanged<String>? onSearchChanged; // Define the onSearchChanged callback

  const MySearch({Key? key, this.onSearchChanged}) : super(key: key);

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      onChanged: (value) {
        if (widget.onSearchChanged != null) {
          widget.onSearchChanged!(value); // Call the onSearchChanged callback
        }
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Color(0xFFF8FAFC),
        hintText: "Search..",
        prefixIcon: Icon(CupertinoIcons.search),
        suffixIcon: Icon(Icons.filter_alt_outlined),
      ),
    );
  }
}

