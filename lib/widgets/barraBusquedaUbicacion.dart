import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turisteando_ando/blocs/autocomplete/auto_complete_bloc.dart';
import 'package:turisteando_ando/blocs/place/place_bloc.dart';

class BarraBusquedaUbicacion extends StatefulWidget {
  @override
  _BarraBusquedaUbicacionState createState() => _BarraBusquedaUbicacionState();
}

class _BarraBusquedaUbicacionState extends State<BarraBusquedaUbicacion> {
  TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutoCompleteBloc, AutoCompleteState>(
      builder: (context, state) {
        if (state is AutoCompleteLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AutoCompleteLoaded) {
          bool isTextFieldEmpty = _textController.text.isEmpty;
          return Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                children: [
                  TextField(
                    style: const TextStyle(color: Colors.black),
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Buscar ubicación',
                      prefixIcon:
                          const Icon(Icons.search, color: Color(0xFF114C5F)),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _textController.clear();
                          });
                        },
                      ),
                      labelText: 'Buscar ubicación',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      context
                          .read<AutoCompleteBloc>()
                          .add(LoadAutoComplete(searchInput: value));
                    },
                  ),
                  Visibility(
                      visible:
                          !isTextFieldEmpty && state.autocomplete.isNotEmpty,
                      child: Container(
                        margin: const EdgeInsets.only(top: 1),
                        height: 200,
                        color: Colors.white.withOpacity(0.6),
                        child: ListView.builder(
                            itemCount: state.autocomplete.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const Icon(Icons.location_pin),
                                title: Text(
                                  state.autocomplete[index].descripcion,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Nunito',
                                    color: Colors.black,
                                  ),
                                ),
                                onTap: () {
                                  context.read<PlaceBloc>().add(LoadPlace(
                                        placeId:
                                            state.autocomplete[index].placeId,
                                      ));
                                  context.read<AutoCompleteBloc>().add(
                                      AutoCompleteSelected(
                                          selectedText: state
                                              .autocomplete[index]
                                              .descripcion));
                                },
                              );
                            }),
                      ))
                ],
              ));
        } else if (state is AutoCompleteSelectedState) {
          _textController.text = state.selectedText;
          return Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                children: [
                  TextField(
                    style: const TextStyle(color: Colors.black),
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Buscar ubicación',
                      prefixIcon:
                          const Icon(Icons.search, color: Color(0xFF114C5F)),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _textController.clear();
                          });
                        },
                      ),
                      labelText: 'Buscar ubicación',
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      context
                          .read<AutoCompleteBloc>()
                          .add(LoadAutoComplete(searchInput: value));
                    },
                  ),
                ],
              ));
        } else {
          return const Text('Algo salio mal...');
        }
      },
    );
  }
}
