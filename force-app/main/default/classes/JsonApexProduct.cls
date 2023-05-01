public class JsonApexProduct {
    
    public class PricebookEntries {
        public String Product2Id;
        public String Id;
        public Integer UnitPrice;
    }
    public Boolean isCheckBox;
    public Integer priceDec;
    public ProductObj productObj;
    public Boolean checked;
    
    public class ProductObj {
        public String Name;
        public String ProductCode;
        public String Id;
        public List<PricebookEntries> PricebookEntries;
    }
    public static List<JsonApexProduct> parse(String json) {
        return (List<JsonApexProduct>) System.JSON.deserialize(json, List<JsonApexProduct>.class);
    }
}