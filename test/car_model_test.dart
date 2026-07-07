import 'package:car_coop_app/data/models/car.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Car.fromJson', () {
    test('accepts nullable display fields from the API', () {
      final car = Car.fromJson({
        'id': 1,
        'name': null,
        'licensePlate': null,
        'members': [
          {'id': 2, 'name': null},
        ],
      });

      expect(car.name, '');
      expect(car.licensePlate, '');
      expect(car.members.single.name, '');
    });
  });
}
