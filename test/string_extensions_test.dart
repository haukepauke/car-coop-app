import 'package:flutter_test/flutter_test.dart';

import 'package:car_coop_app/core/extensions/string_extensions.dart';

void main() {
  test('toIri builds API resource paths', () {
    expect(toIri('cars', 42), '/api/cars/42');
    expect(toIri('expenses', 7), '/api/expenses/7');
  });
}
