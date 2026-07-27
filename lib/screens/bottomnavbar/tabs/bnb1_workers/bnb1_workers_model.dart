import 'package:constructo_worker/networking/extensions/api_helper.dart';

class Bnb1WorkerModel {
  final String name;
  final String category;
  final String image;
  final String experience;
  final String price;
  final String location;
  final String availability;
  final double rating;
  final bool verified;

  Bnb1WorkerModel.fromMap(Map data)
    : name = apiPeramString(data['name']),
      category = apiPeramString(data['category']),
      image = apiPeramString(data['image']),
      experience = apiPeramString(data['experience']),
      price = apiPeramString(data['price']),
      location = apiPeramString(data['location']),
      availability = apiPeramString(data['availability']),
      rating = apiPeramDouble(data['rating']),
      verified = apiPeramBool(data['verified']);
}
