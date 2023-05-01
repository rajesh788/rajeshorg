public class JSON2ApexCustomField {

    public class CreatedBy {
        public Attributes attributes;
        public String Name;
    }

    public Integer size;
    public Integer totalSize;
    public Boolean done;
    public Object queryLocator;
    public String entityTypeName;
    public List<Records> records;

    public class Attributes {
        public String type;
        public String url;
    }

    public class Records {
        public Attributes attributes;
        public Object NamespacePrefix;
        public String DeveloperName;
        public CreatedBy CreatedBy;
        public String TableEnumOrId;
        public DateTime CreatedDate;
    }

    
    public static JSON2Apex parse(String json) {
        return (JSON2Apex) System.JSON.deserialize(json, JSON2Apex.class);
    }
}