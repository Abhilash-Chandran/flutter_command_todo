// // @dart=2.9

// import 'package:async/async.dart';

// void main() {
//   Future<String> future1 = getData(2);
//   Future<String> future2 = getData(4);
//   Future<String> future3 = getData(6);
//   FutureGroup futureGroup = FutureGroup();
//   futureGroup.add(future1);
//   futureGroup.add(future2);
//   futureGroup.add(future3);
//   futureGroup.close();
//   futureGroup.future.then((value) => {print(value)});
// }

// Future<String> getData(int duration) async {
//   await Future.delayed(Duration(seconds: duration)); //Mock delay
//   return "This a test data";
// }
