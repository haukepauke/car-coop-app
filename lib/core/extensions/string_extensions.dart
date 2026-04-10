extension IriExtension on String {
  /// Extracts the integer ID from an IRI like "/api/cars/3" → 3
  int get iriId => int.parse(split('/').last);
}

/// Builds an IRI string, e.g. toIri('cars', 3) → '/api/cars/3'
String toIri(String type, int id) => '/api/$type/$id';
