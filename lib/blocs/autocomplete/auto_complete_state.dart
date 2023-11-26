part of 'auto_complete_bloc.dart';

abstract class AutoCompleteState extends Equatable {
  const AutoCompleteState();
  
  @override
  List<Object> get props => [];
}

final class AutoCompleteLoading extends AutoCompleteState {}

class AutoCompleteLoaded extends AutoCompleteState {
  final List<PlaceAutocomplete> autocomplete;

  const AutoCompleteLoaded({required this.autocomplete});

  @override
  List<Object> get props => [autocomplete];
}

final class AutoCompleteError extends AutoCompleteState {}

class AutoCompleteSelectedState extends AutoCompleteState {
  final String selectedText;

  AutoCompleteSelectedState({required this.selectedText});
}

