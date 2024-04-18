class Item {
  String? title;
  String? category;
  String? thumb_url;
  String? location;
  double? price;
  bool isInWishlist;

  static List<Item> allItems = [...recommendation, ...nearby]; // Initialize allItems list

  Item(this.title, this.category, this.location, this.price, this.thumb_url, {this.isInWishlist = false});

  static List<Item> recommendation = [
    Item(
      "Modern House ",
      "House",
      "Pedatadepalli, India",
      2500000, // Price in rupees
      "https://cdn.pixabay.com/photo/2016/06/24/10/47/house-1477041_1280.jpg",
    ),
    Item(
      "Big Villa",
      "Villa",
      "Ap, India",
      1000000, // Price in rupees
      "https://cdn.pixabay.com/photo/2017/05/29/19/48/usa-2354659_1280.jpg",
    ),
    Item(
      "Small House",
      "House",
      "Ap India",
      100500, // Price in rupees
      "https://cdn.pixabay.com/photo/2015/08/25/14/16/small-wooden-house-906912_1280.jpg",
    ),
    Item(
      "Luxios Apartment",
      "Apartment",
      "Rjy, India",
      8000000, // Price in rupees
      "https://cdn.pixabay.com/photo/2016/11/29/02/23/apartment-1866833_640.jpg",
    ),
  ];

  static List<Item> nearby = [
    Item(
      "Student Apartment",
      "Apartment",
      "Telangana, India",
      2507400, // Price in rupees
      "https://cdn.pixabay.com/photo/2016/11/21/15/09/apartments-1845884_1280.jpg",
    ),
    Item(
      "Small Villa",
      "Villa",
      ", India",
      3750000, // Price in rupees
      "https://cdn.pixabay.com/photo/2015/11/06/11/39/single-family-home-1026368_640.jpg",
    ),
    Item(
      "Family HOUSE",
      "House",
      "Vizag, India",
      2504000, // Price in rupees
      "https://cdn.pixabay.com/photo/2018/02/13/11/09/home-3150500_640.jpg",
    ),
    Item(
      "Province House",
      "House",
      "Ap, India",
      108000, // Price in rupees
      "https://cdn.pixabay.com/photo/2016/07/16/13/34/roussillon-1521763_640.jpg",
    ),
  ];
}