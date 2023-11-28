import 'package:turisteando_ando/models/places/PlaceAutocompleteModel.dart';
import 'package:turisteando_ando/models/places/place_model.dart';

//Clase para ...
abstract class BasePlacesRepository {
  Future<List<PlaceAutocomplete>?> getAutocomplete(String searchInput) async {}

  Future<Place?> getPlace(String placeId) async{}
}