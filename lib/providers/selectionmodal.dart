import '/models/selection.dart';


import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define the provider
final selectionModelProvider =
    StateNotifierProvider<SelectionModelNotifier, SelectionModel>((ref) {
  return SelectionModelNotifier();
});

// StateNotifier implementation remains the same as previously defined
class SelectionModelNotifier extends StateNotifier<SelectionModel> {
  SelectionModelNotifier() : super(SelectionModel());

  void toggleCheckBox(bool? checkBoxValue) {
    if (checkBoxValue != null) {
      state = state.copyWith(checkBox: checkBoxValue);
    }
  }
void changePassword(bool? value) {
    
      state = state.copyWith(changePassword: value);
    
  }
  void toggleEditUser(bool? value) {
    
      state = state.copyWith(editUser: value);
    
  }

// void toggleDashboard() {
    
//       state = state.copyWith(dashboard: !state.dashboard!);
    
//   }

  void userIndex(int?value) {
    
      state = state.copyWith(userIndex: value);
    
  }

   void subscriberIndex(int?value) {
    
      state = state.copyWith(subscriberIndex: value);
    
  }


void subDetails(bool?value) {
    
      state = state.copyWith(subDetails: value);
    
  }

void toggleLogin(bool?value) {
    
      state = state.copyWith(loginEmail: value);
    
  }

void setGender(String gender) {
    state = state.copyWith(gender: gender);
  }
void setSub(String gender) {
    state = state.copyWith(sub: gender);
  }

  void updateEnteredemail(String newText) {
   
    state.email.text =
        newText; 

    
    state = state
        .copyWith(); // This is a hacky way to force a rebuild. Consider better state management for TextEditingController.
  }

  void updateEnteredName(String newText) {
       state.name.text =
        newText; 
        
    state = state
        .copyWith(); // This is a hacky way to force a rebuild. Consider better state management for TextEditingController.
  }
   void updateEnteredPassword(String newText) {
       state.password.text =
        newText; 
        
    state = state
        .copyWith(); // This is a hacky way to force a rebuild. Consider better state management for TextEditingController.
  }
  void updateSubname(String newText) {
       state.subName.text =
        newText; 
        
    state = state
        .copyWith(); // This is a hacky way to force a rebuild. Consider better state management for TextEditingController.
  }
  void updateAnnualP(String newText) {
       state.annualP.text =
        newText; 
        
    state = state
        .copyWith(); // This is a hacky way to force a rebuild. Consider better state management for TextEditingController.
  }
  void updateLocation(String newText) {
       state.location.text =
        newText; 
        
    state = state
        .copyWith(); // This is a hacky way to force a rebuild. Consider better state management for TextEditingController.
  }
  void updateMonthlyP(String newText) {
       state.monthlyP.text =
        newText; 
        
    state = state
        .copyWith(); // This is a hacky way to force a rebuild. Consider better state management for TextEditingController.
  }

  void updateVenderName(String newText) {
       state.venderName.text =
        newText; 
        
    state = state
        .copyWith(); // This is a hacky way to force a rebuild. Consider better state management for TextEditingController.
  }
  void updateVenderEmail(String newText) {
       state.venderEmail.text =
        newText; 
        
    state = state
        .copyWith(); // This is a hacky way to force a rebuild. Consider better state management for TextEditingController.
  }
  void updateVenderContact(String newText) {
       state.venderContact.text =
        newText; 
        
    state = state
        .copyWith(); // This is a hacky way to force a rebuild. Consider better state management for TextEditingController.
  }
  void updateVenderAD1(String newText) {
       state.venderAD1.text =
        newText; 
        
    state = state
        .copyWith(); // This is a hacky way to force a rebuild. Consider better state management for TextEditingController.
  }
  void updateVenderAD2(String newText) {
       state.venderAD2.text =
        newText; 
        
    state = state
        .copyWith(); // This is a hacky way to force a rebuild. Consider better state management for TextEditingController.
  }
  void updateVenderState(String newText) {
       state.venderState.text =
        newText; 
        
    state = state
        .copyWith(); // This is a hacky way to force a rebuild. Consider better state management for TextEditingController.
  }
  void updateVenderCity(String newText) {
       state.venderCity.text =
        newText; 
        
    state = state
        .copyWith(); // This is a hacky way to force a rebuild. Consider better state management for TextEditingController.
  }
  void updateVenderPincode(String newText) {
       state.vendeerPincode.text =
        newText; 
        
    state = state
        .copyWith(); // This is a hacky way to force a rebuild. Consider better state management for TextEditingController.
  }
  void updateAdminEmail(String newText) {
       state.adminEmail.text =
        newText; 
        
    state = state
        .copyWith(); // This is a hacky way to force a rebuild. Consider better state management for TextEditingController.
  }
  void updateAdminPassword(String newText) {
       state.adminPassword.text =
        newText; 
        
    state = state
        .copyWith(); // This is a hacky way to force a rebuild. Consider better state management for TextEditingController.
  }
 
}
