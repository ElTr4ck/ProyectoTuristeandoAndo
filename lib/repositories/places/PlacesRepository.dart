import 'package:turisteando_ando/models/places/PlaceAutocompleteModel.dart';
import 'package:turisteando_ando/models/places/place_model.dart';
import 'package:turisteando_ando/repositories/places/BasePlacesRepository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesRepository extends BasePlacesRepository{
  final String key = 'AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM';
  final String types = 'geocode';

  @override
  Future<List<PlaceAutocomplete>> getAutocomplete(String searchInput) async {
    final String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchInput&types=$types&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['predictions'] as List;

    return results.map((place) => PlaceAutocomplete.fromJSON(place)).toList();
  }

  @override
  Future<Place> getPlace(String placeId) async {
      final String url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';

      var response = await http.get(Uri.parse(url));
      var json = convert.jsonDecode(response.body);
      var results = json['result'] as Map<String, dynamic>;

      return Place.fromJSON(results);  
  }
}