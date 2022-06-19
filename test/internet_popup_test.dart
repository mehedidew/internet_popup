import 'package:internet_popup/internet_popup.dart';
import 'package:test/test.dart';

void main() {
  test('check if internet connection is there -', () async {
    //arrange
    bool b = await InternetPopup().checkInternet();

    //act

    //assert
    expect(b, false);
  });
}
