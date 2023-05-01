@isTest
public class LeadSrc_Test {
    @testSetup
    public static void testSetup(){
        
    }
    @isTest
    public static void LeadSrc_TestMtd(){
        
        Lead leadRec1 = new Lead (LastName='test67',Company='Kskj',Status='Working - Contacted',phone='',MobilePhone='',Email='');
        insert leadRec1;
    }
}