public class DocumentFactoryExample {
    interface Document {
        void open();
    }
    static class WordDocument implements Document {
        public void open() {
            System.out.println("Opening a Word document.");
        }
    }

    static class PdfDocument implements Document {
        public void open() {
            System.out.println("Opening a PDF document.");
        }
    }

    static class ExcelDocument implements Document {
        public void open() {
            System.out.println("Opening an Excel document.");
        }
    }
    static abstract class DocumentFactory {
        public abstract Document createDocument();
    }

    static class WordDocumentFactory extends DocumentFactory {
        public Document createDocument() {
            return new WordDocument();
        }
    }

    static class PdfDocumentFactory extends DocumentFactory {
        public Document createDocument() {
            return new PdfDocument();
        }
    }

    static class ExcelDocumentFactory extends DocumentFactory {
        public Document createDocument() {
            return new ExcelDocument();
        }
    }
    public static void main(String[] args) {
        DocumentFactory wordFactory = new WordDocumentFactory();
        Document word = wordFactory.createDocument();
        word.open();

        DocumentFactory pdfFactory = new PdfDocumentFactory();
        Document pdf = pdfFactory.createDocument();
        pdf.open();

        DocumentFactory excelFactory = new ExcelDocumentFactory();
        Document excel = excelFactory.createDocument();
        excel.open();
    }
}

