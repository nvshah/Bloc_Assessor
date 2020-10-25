import 'package:meta/meta.dart';

class Movie {
  final String name;
  final double ratings;

  Movie({
    @required this.name,
    @required this.ratings,
  });
  
  //? For Value Equality instead refrential equality
  // == and hashcode overrides ...
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Movie &&
        o.name == name &&
        o.ratings == ratings;
  }

  @override
  int get hashCode => name.hashCode ^ ratings.hashCode;
}