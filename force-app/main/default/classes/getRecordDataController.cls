public with sharing class getRecordDataController {
 //@AuraEnabled is annotation enables LWC to access below apex method
 //(cacheable=true) is for caching the data on client side storage without 
//   waiting for server trips. Which imporves the performance
 @AuraEnabled(cacheable=true)
  public static List<contact> getAccounts(Id recordId){
      system.debug('recordID'+recordID);
  return [SELECT Id, LastName, Phone FROM contact where Id =:recordId];
  }
}