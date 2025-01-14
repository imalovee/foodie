import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class UserController extends GetxController{
  var name = ''.obs;
  var image = ''.obs;

  void setUser({
    required String userName,
    required String photoUrl,
}){
    name.value = userName;
    image.value = photoUrl;
  }

}