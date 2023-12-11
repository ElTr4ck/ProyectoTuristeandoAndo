part of 'auto_complete_bloc.dart';

abstract class AutoCompleteEvent extends Equatable {
  const AutoCompleteEvent();

  @override
  List<Object> get props => [];
}

class LoadAutoComplete extends AutoCompleteEvent {
  final String searchInput;

  LoadAutoComplete({this.searchInput = ''});

  @override
  List<Object> get props => [searchInput];
}

class AutoCompleteSelected extends AutoCompleteEvent {
  final String selectedText;

  AutoCompleteSelected({required this.selectedText});
}

