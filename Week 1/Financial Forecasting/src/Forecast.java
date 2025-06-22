public class Forecast {
    public static double forecastRecursive(double presentValue, double rate, int years) {
        if (years == 0) return presentValue;
        return forecastRecursive(presentValue * (1 + rate), rate, years - 1);
    }
    public static double forecastIterative(double presentValue, double rate, int years) {
        for (int i = 0; i < years; i++) {
            presentValue *= (1 + rate);
        }
        return presentValue;
    }
    public static void main(String[] args) {
        double present = 1000;
        double rate = 0.10;
        int years = 5;
        double recursiveResult = forecastRecursive(present, rate, years);
        System.out.printf("Recursive Forecast after %d years: ₹%.2f%n", years, recursiveResult);
        double iterativeResult = forecastIterative(present, rate, years);
        System.out.printf("Iterative Forecast after %d years: ₹%.2f%n", years, iterativeResult);
    }
}
