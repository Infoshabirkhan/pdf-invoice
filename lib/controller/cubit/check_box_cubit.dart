import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


class CheckBoxCubit extends Cubit<bool> {
  CheckBoxCubit(super.initialState);

  getStatus({required status}){

    emit(status);
  }
}
