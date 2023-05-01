public class TICalloutWrapper{
	public List <clsData> data;
	public class clsData {
		public String id;	//44bfbaf2-3add-44c9-870b-bd67f88fabb8
		public String clientId;	//
		public String disabled;	//false
		public String sfAccountId;	//
		public String sfContactId;	//
		public String externalCustomerId;	//
		public String email;	//vrushalij@knowledgesynonyms.com
		public String firstName;	//Vrushali
		public String lastName;	//Nalawade
		public String lastActiveAt;	//2023-02-23T07:53:16.311000-08:00
		public String ref1;	//
		public String ref2;	//
		public String ref3;	//
		public String ref4;	//
		public String ref5;	//
		public String ref6;	//
		public String ref7;	//
		public String ref8;	//
		public String ref9;	//
		public String ref10;	//
	}
	public TICalloutWrapper parseMtd(String json){
		return (TICalloutWrapper) System.JSON.deserialize(json, TICalloutWrapper.class);
	}
}