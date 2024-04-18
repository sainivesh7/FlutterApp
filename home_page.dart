import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:socproject/components/my_search.dart';
import 'package:socproject/components/select_category.dart';
import 'package:socproject/components/suggestion_list.dart';
import 'package:socproject/pages/items_model.dart';
import 'package:socproject/pages/profile_page.dart';
import 'package:socproject/pages/wishlist_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _currentLocation = '';
  String _selectedCategory = "";
  String _searchText = "";
  List<Item> _allItems = Item.allItems;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      Position position = await _determinePosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      setState(() {
        _currentLocation = "${placemarks.first.street}, ${placemarks.first.subLocality}, ${placemarks.first.locality},${placemarks.first.name}";
      });
    } catch (e) {
      print("Error fetching location: $e");
      setState(() {
        _currentLocation = "Pedatadepalli, India"; // Provide a default location in case of an error.
      });
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationServiceDisabledException('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationPermissionDeniedException('Location permissions are denied.');
      }
    } else if (permission == LocationPermission.deniedForever) {
      throw LocationPermissionPermanentDeniedException('Location permissions are permanently denied.');
    }

    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      throw PositionFetchException('Error fetching position: $e');
    }
  }

  void _updateSearchText(String text) {
    setState(() {
      _searchText = text;
    });
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Item> filteredItems = _allItems.where((item) => item.title!.toLowerCase().contains(_searchText.toLowerCase())).toList();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        toolbarHeight: 80.0,
        title: Row(
          children: [
            Icon(
              Icons.location_on,
              color: Colors.blue.shade600,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _currentLocation.isNotEmpty ? _currentLocation : "Fetching location...",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              MySearch(onSearchChanged: _updateSearchText),
              const SizedBox(
                height: 20.0,
              ),
              if (_searchText.isNotEmpty)
                SuggestionList(
                  "Search Results",
                  filteredItems,
                ),
              SelectCategory(
                onCategorySelected: _selectCategory,
              ),
              SizedBox(
                height: 20.0,
              ),
              SuggestionList(
                "Recommendation for you",
                _selectedCategory.isEmpty
                    ? Item.recommendation
                    : Item.recommendation.where((item) => item.category == _selectedCategory).toList(),
              ),
              SizedBox(
                height: 20.0,
              ),
              SuggestionList(
                "Properties near you",
                _selectedCategory.isEmpty
                    ? Item.nearby
                    : Item.nearby.where((item) => item.category == _selectedCategory).toList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey.shade600,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WishlistScreen(
                  wishlist: _allItems.where((item) => item.isInWishlist).toList(),
                ),
              ),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart),
            label: "Wishlist",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: "Account",
          ),
        ],
      ),
    );
  }
}

class LocationServiceDisabledException implements Exception {
  final String message;
  LocationServiceDisabledException(this.message);
}

class LocationPermissionDeniedException implements Exception {
  final String message;
  LocationPermissionDeniedException(this.message);
}

class LocationPermissionPermanentDeniedException implements Exception {
  final String message;
  LocationPermissionPermanentDeniedException(this.message);
}

class PositionFetchException implements Exception {
  final String message;
  PositionFetchException(this.message);
}
