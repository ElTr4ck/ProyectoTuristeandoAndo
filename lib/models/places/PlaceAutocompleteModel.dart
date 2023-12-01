// Este model sirve para la api de google places y el autocompletado de lugares

class PlaceAutocomplete{
  final String descripcion;
  final String placeId;

  PlaceAutocomplete({required this.descripcion, required this.placeId});

  factory PlaceAutocomplete.fromJSON(Map<String, dynamic> json){
    return PlaceAutocomplete(
      descripcion: json['description'], 
      placeId: json['place_id']
    );
  }
}