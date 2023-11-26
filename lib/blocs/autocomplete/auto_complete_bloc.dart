import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:turisteando_ando/models/places/PlaceAutocompleteModel.dart';
import 'package:turisteando_ando/repositories/places/PlacesRepository.dart';

part 'auto_complete_event.dart';
part 'auto_complete_state.dart';

class AutoCompleteBloc extends Bloc<AutoCompleteEvent, AutoCompleteState> {
  final PlacesRepository _placesRepository;
  StreamSubscription? _placesSubscription;

  AutoCompleteBloc({required PlacesRepository placesRepository})
      : _placesRepository = placesRepository,
        super(AutoCompleteLoading());

  @override
  Stream<AutoCompleteState> mapEventToState(
    AutoCompleteEvent event,
  ) async* {
    if (event is LoadAutoComplete) {
      yield* _mapLoadAutocompleteToState(event);
    }
  }

  Stream<AutoCompleteState> _mapLoadAutocompleteToState(
      LoadAutoComplete event) async* {
    _placesSubscription?.cancel();

    final List<PlaceAutocomplete> autocomplete =
        await _placesRepository.getAutocomplete(event.searchInput);

    yield AutoCompleteLoaded(autocomplete: autocomplete);
  }
}