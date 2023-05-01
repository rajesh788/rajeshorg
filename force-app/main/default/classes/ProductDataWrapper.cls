public class ProductDataWrapper {
	public List<products> products;
	public class products {
		public Integer id;	    
		public String title;	   
		public String description;	  
		public Integer price;	    
		public Double discountPercentage;	   
		public Double rating;	    
		public Integer stock;	    
		public String brand;	    
		public String category;	    
		public String thumbnail;	    
		public List<String> images;
	}
    
    public ProductDataWrapper getJSONDeslize(String json){
         return (ProductDataWrapper) System.JSON.deserialize(json, ProductDataWrapper.class);
    }
}