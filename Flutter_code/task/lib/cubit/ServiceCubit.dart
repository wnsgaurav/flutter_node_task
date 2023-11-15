import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/cubit/ServiceCheckboxState.dart';
import 'package:task/modal/servicemodal.dart';

class CheckboxCubit extends Cubit<CheckboxState> {
  bool addService = true;

  CheckboxCubit() : super(CheckBoxInitialState(checkState: false));

  void countCheck(bool value, ServiceModal serviceList, int count){
    if(value){
      if(count>3){
        addService = false;
      }else {
        if(count == 2){
          addService = false;
        }
        emit(CheckBoxCheckedState(checkState: addService, count: count+1));
      }
    }else{
      count--;
      addService = true;
      emit(CheckBoxCheckedState(checkState: addService,count : count));

    }
  }


}