public class ProductJSON {
	public static List<String> parse(String json) {
		return (List<String>) System.JSON.deserialize(json, List<String>.class);
	}
}