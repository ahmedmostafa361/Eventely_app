import 'package:evently_app_flutter/model/my_users.dart';
import 'package:flutter/foundation.dart';

class MyUsersProvider extends ChangeNotifier {
  ///todo: data when change effect to many places
  MyUsers? currentUser;

  ///todo: func. will effect on this data
  void updateUsers(MyUsers myUsers) {
    currentUser = myUsers;
    notifyListeners();

    /// if we used it in build we must change listen to => false
  }
}
