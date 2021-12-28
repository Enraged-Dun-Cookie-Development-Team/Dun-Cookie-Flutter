import 'main.dart';

class MainRequest {
  static Future canteenCardList() {
    const list = "http://81.68.101.79:3000/canteen/cardList";
    return HttpClass.get(list);
  }

  static void test() {
    const list = "http://81.68.101.79:3000/canteen/cardList";
    return HttpClass.test(list);
  }
}
