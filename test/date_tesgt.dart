import 'package:flutter_test/flutter_test.dart';

void main()
{
  test("Test Date", () {
    
    String dateTime = DateTime.now().toIso8601String();
    String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();

    print("DateTime: $dateTime , timeStamp: $timeStamp");

  });
}