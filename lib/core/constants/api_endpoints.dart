class ApiEndpoints {
  static String getUrl(String barcode) {
    return "https://world.openfoodfacts.org/api/v0/product/$barcode.json";
  }
}
