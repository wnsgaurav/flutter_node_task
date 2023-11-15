/*
class CheckboxState {
  bool ischecked = false;


  CheckboxState({required this.ischecked}) {
    if (ischecked) {
      ischecked = true;

    } else {
      ischecked = false;
    }
  }

  CheckboxState copyWith({required bool changeState}) {
    return CheckboxState(ischecked: changeState);
  }
}*/

class CheckboxState {}
class CheckBoxCountState extends CheckboxState {
  int count;
  CheckBoxCountState({required this.count});
}
class CheckBoxInitialState extends CheckboxState {
  bool checkState;
  CheckBoxInitialState({required this.checkState});
}
class CheckBoxCheckedState extends CheckboxState {
  bool checkState;
  int count;
  CheckBoxCheckedState({required this.checkState, required this.count});
}
