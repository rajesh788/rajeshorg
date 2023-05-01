public class TestCalloutWrapper {
    public class Contacts {
        public Integer totalSize {get;set;} 
        public Boolean done {get;set;} 
        public List<Records_Z> records {get;set;} 
        
        public Contacts(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'totalSize') {
                            totalSize = parser.getIntegerValue();
                        } else if (text == 'done') {
                            done = parser.getBooleanValue();
                        } else if (text == 'records') {
                            records = arrayOfRecords_Z(parser);
                        } else {
                            System.debug(LoggingLevel.WARN, 'Contacts consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    public class Records_Z {
        public Attributes attributes {get;set;} 
        public String AccountId {get;set;} 
        public String Id {get;set;} 
        public String FirstName {get;set;} 
        public String LastName {get;set;} 
        
        public Records_Z(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'attributes') {
                            attributes = new Attributes(parser);
                        } else if (text == 'AccountId') {
                            AccountId = parser.getText();
                        } else if (text == 'Id') {
                            Id = parser.getText();
                        } else if (text == 'FirstName') {
                            FirstName = parser.getText();
                        } else if (text == 'LastName') {
                            LastName = parser.getText();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Records_Z consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    public class Attributes {
        public String type {get;set;} 
        public String url {get;set;} 
        
        public Attributes(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'type') {
                            type = parser.getText();
                        } else if (text == 'url') {
                            url = parser.getText();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Attributes consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    public Attributes attributes {get;set;} 
    public String Id {get;set;} 
    public String Name {get;set;} 
    public String Phone {get;set;} 
    public String Website {get;set;} 
    public Opportunities Opportunities {get;set;} 
    public Contacts Contacts {get;set;} 
    
    public TestCalloutWrapper(JSONParser parser) {
        while (parser.nextToken() != System.JSONToken.END_OBJECT) {
            if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                String text = parser.getText();
                if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                    if (text == 'attributes') {
                        attributes = new Attributes(parser);
                    } else if (text == 'Id') {
                        Id = parser.getText();
                    } else if (text == 'Name') {
                        Name = parser.getText();
                    } else if (text == 'Phone') {
                        Phone = parser.getText();
                    } else if (text == 'Website') {
                        Website = parser.getText();
                    } else if (text == 'Opportunities') {
                        Opportunities = new Opportunities(parser);
                    } else if (text == 'Contacts') {
                        Contacts = new Contacts(parser);
                    } else {
                        System.debug(LoggingLevel.WARN, 'TestCalloutWrapper consuming unrecognized property: '+text);
                        consumeObject(parser);
                    }
                }
            }
        }
    }
    
    public class Opportunities {
        public Integer totalSize {get;set;} 
        public Boolean done {get;set;} 
        public List<Records> records {get;set;} 
        
        public Opportunities(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'totalSize') {
                            totalSize = parser.getIntegerValue();
                        } else if (text == 'done') {
                            done = parser.getBooleanValue();
                        } else if (text == 'records') {
                            records = arrayOfRecords(parser);
                        } else {
                            System.debug(LoggingLevel.WARN, 'Opportunities consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    public class Records {
        public Attributes attributes {get;set;} 
        public String AccountId {get;set;} 
        public String Id {get;set;} 
        public String Name {get;set;} 
        
        public Records(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'attributes') {
                            attributes = new Attributes(parser);
                        } else if (text == 'AccountId') {
                            AccountId = parser.getText();
                        } else if (text == 'Id') {
                            Id = parser.getText();
                        } else if (text == 'Name') {
                            Name = parser.getText();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Records consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    public static List<TestCalloutWrapper> parse(String json) {
        System.JSONParser parser = System.JSON.createParser(json);
        return arrayOfTestCalloutWrapper(parser);
    }
    
    public static void consumeObject(System.JSONParser parser) {
        Integer depth = 0;
        do {
            System.JSONToken curr = parser.getCurrentToken();
            if (curr == System.JSONToken.START_OBJECT || 
                curr == System.JSONToken.START_ARRAY) {
                    depth++;
                } else if (curr == System.JSONToken.END_OBJECT ||
                           curr == System.JSONToken.END_ARRAY) {
                               depth--;
                           }
        } while (depth > 0 && parser.nextToken() != null);
    }
    
    private static List<TestCalloutWrapper> arrayOfTestCalloutWrapper(System.JSONParser p) {
        List<TestCalloutWrapper> res = new List<TestCalloutWrapper>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new TestCalloutWrapper(p));
        }
        return res;
    }
    
    private static List<Records> arrayOfRecords(System.JSONParser p) {
        List<Records> res = new List<Records>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Records(p));
        }
        return res;
    }
    
    private static List<Records_Z> arrayOfRecords_Z(System.JSONParser p) {
        List<Records_Z> res = new List<Records_Z>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Records_Z(p));
        }
        return res;
    }
}