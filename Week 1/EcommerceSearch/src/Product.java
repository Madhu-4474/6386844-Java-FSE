import java.util.*;
public class Product {
    static class ProductItem {
        int productId;
        String productName;
        String category;
        public ProductItem(int productId, String productName, String category) {
            this.productId = productId;
            this.productName = productName;
            this.category = category;
        }
        public String toString() {
            return "[" + productId + " - " + productName + " - " + category + "]";
        }
    }
    public static ProductItem linearSearch(ProductItem[] products, int targetId) {
        for (ProductItem product : products) {
            if (product.productId == targetId) {
                return product;
            }
        }
        return null;
    }
    public static ProductItem binarySearch(ProductItem[] products, int targetId) {
        int left = 0, right = products.length - 1;
        while (left <= right) {
            int mid = (left + right) / 2;
            if (products[mid].productId == targetId) {
                return products[mid];
            } else if (products[mid].productId < targetId) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return null;
    }
    public static void main(String[] args) {
        ProductItem[] products = {
                new ProductItem(102, "Laptop", "Electronics"),
                new ProductItem(205, "Shoes", "Fashion"),
                new ProductItem(101, "Phone", "Electronics"),
                new ProductItem(310, "Watch", "Accessories"),
                new ProductItem(150, "Bag", "Fashion")
        };
        ProductItem[] sortedProducts = products.clone();
        Arrays.sort(sortedProducts, Comparator.comparingInt(p -> p.productId));
        System.out.println("Linear Search for ID 310:");
        ProductItem linearResult = linearSearch(products, 310);
        System.out.println(linearResult != null ? linearResult : "Product not found.");
        System.out.println("\nBinary Search for ID 310:");
        ProductItem binaryResult = binarySearch(sortedProducts, 310);
        System.out.println(binaryResult != null ? binaryResult : "Product not found.");
    }
}
