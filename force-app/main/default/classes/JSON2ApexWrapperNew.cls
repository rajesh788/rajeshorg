public class JSON2ApexWrapperNew {
    public class CreatedBy {
		public Attributes attributes;
		public String Name;
	}

	public Attributes attributes;
	public Object NamespacePrefix;
	public String DeveloperName;
	public CreatedBy CreatedBy;
	public String TableEnumOrId;
	public String CreatedDate;

	public class Attributes {
		public String type;
		public String url;
	}

	
	public static List<JSON2ApexWrapperNew> parse(String json) {
		return (List<JSON2ApexWrapperNew>) System.JSON.deserialize(json, List<JSON2ApexWrapperNew>.class);
	}

}