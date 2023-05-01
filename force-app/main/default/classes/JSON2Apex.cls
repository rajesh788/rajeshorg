public class JSON2Apex {

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
        public Decimal Quantity;
        
		public List<PricebookEntries> PricebookEntries;
	}

	
	public static List<JSON2Apex> parse(String json) {
		return (List<JSON2Apex>) System.JSON.deserialize(json, List<JSON2Apex>.class);
	}
}