import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


class ListCubit extends Cubit<int> {
  ListCubit(super.initialState);

  getList({required index}){
    emit(index);
  }
}
