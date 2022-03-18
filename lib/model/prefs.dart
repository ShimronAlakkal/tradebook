import 'package:shared_preferences/shared_preferences.dart';

class DepositNWithdraw {
  int mode; // If the process was deposit or withdrawal. 0 = w , 1 = d
  double amount;

  DepositNWithdraw({this.amount, this.mode});

  Future<SharedPreferences> getInstance() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    return instance;
  }
}
