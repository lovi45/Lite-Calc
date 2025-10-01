class CalcLogic {
  static double add(double a, double b) => a + b;
  static double subtract(double a, double b) => a - b;
  static double multiply(double a, double b) => a * b;
  static double divide(double a, double b) {
    if (b == 0) throw Exception("Cannot divide by zero");
    return a / b;
  }
}
