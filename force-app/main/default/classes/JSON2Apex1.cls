public class JSON2Apex1 {
    public String Account;
    public List<String> contacts;
    
    
    public static JSON2Apex1 parse(String json) {
        return (JSON2Apex1) System.JSON.deserialize(json, JSON2Apex1.class);
    }
}