import 'package:flutter_test/flutter_test.dart';
import '../../auth_robot.dart';

void main() {
  testWidgets('Cancel logout', (tester) async {
    final logOut = AuthRobot(tester);
    await logOut.pumpAccountScreen();
    await logOut.tapLogoutButton();
    logOut.expectLogoutDialogFound();
    await logOut.tapCancelButton();
    logOut.expectLogoutDialogNotFound();
  });
}
