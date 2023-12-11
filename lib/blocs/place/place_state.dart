part of 'place_bloc.dart';

abstract class PlaceState extends Equatable {
  const PlaceState();
  
  @override
  List<Object> get props => [];
}

class PlaceLoading extends PlaceState {}

class PlaceLoaded extends PlaceState {
  final Place place;

  const PlaceLoaded({required this.place});

  @override
  List<Object> get props => [place];
}
//Clase para el evento de la geolocalizacion
class PlaceGeolocated extends PlaceState {

  const PlaceGeolocated();
}

class PlaceError extends PlaceState {}
