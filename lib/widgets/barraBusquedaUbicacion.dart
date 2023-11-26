import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turisteando_ando/blocs/autocomplete/auto_complete_bloc.dart';

class BarraBusquedaUbicacion extends StatelessWidget{
  const BarraBusquedaUbicacion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutoCompleteBloc, AutoCompleteState>(
      builder: (context, state){
        if (state is AutoCompleteLoading){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(state is AutoCompleteLoaded){
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Ingresa tu ubicación',
                prefixIcon:
                    Icon(Icons.search, color: Color(0xFF114C5F)),
                border: InputBorder.none,
              ),
              onChanged: (value){
                context.read<AutoCompleteBloc>().add(LoadAutoComplete(searchInput: value));
              },
            ),
          );
        }
        else{return const Text('Algo salio mal...');}
      },
    );
  }

}