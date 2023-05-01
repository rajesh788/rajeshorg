trigger CampaignMemberTrigger on CampaignMember (After insert) {
    if(trigger.isAfter){
        if(trigger.isInsert){
            Set<Id> cMemberContactIds = new Set <Id>();
            Set<Id> cMemberCampIds = new Set <Id>();
            for(CampaignMember cMember : trigger.new ){
                if(cMember.ContactId!=null){
                    if(cMember.CampaignId!=null)
                        cMemberContactIds.add(cMember.ContactId);
                    cMemberCampIds.add(cMember.CampaignId);
                }
            }
            Map<Id,Integer> accCamMap = new Map <Id,Integer>();
            List <CampaignMember> campaignMemberList =([select id,name,CampaignId,ContactId,Contact.AccountId from CampaignMember where ContactId In : cMemberContactIds]);
            for(CampaignMember campaignMem : campaignMemberList){
                integer campMemberCount=0;
                if(accCamMap.containskey(campaignMem.Contact.AccountId)){
                    campMemberCount = accCamMap.get(campaignMem.Contact.AccountId);
                }
                campMemberCount++;
                if(campaignMem.Contact.AccountId!=null){
                    accCamMap.put(campaignMem.Contact.AccountId,campMemberCount);
                    system.debug('####'+accCamMap);
                }
            }
            Map <Id,Integer> CamNumberMap = new Map <Id,Integer>();
            List <CampaignMember> ListOfcampaignMember =([select id,name,CampaignId,ContactId,Contact.AccountId from CampaignMember where CampaignId In : cMemberCampIds]);
            integer campaignCount=0;
            system.debug('###'+campaignCount);
            for(CampaignMember camp : ListOfcampaignMember){
                if(CamNumberMap.containsKey(camp.CampaignId)){
                    campaignCount = CamNumberMap.get(camp.CampaignId);
                    system.debug('CountCamp'+campaignCount);
                }
                campaignCount++;
                system.debug('@@@'+campaignCount);
                if(camp.CampaignId!=null){
                    CamNumberMap.put(camp.Contact.AccountId,campaignCount);
                    system.debug('@#@#Map'+CamNumberMap);
                }
            }
            List <Account> accList = ([select id,Number_of_campaign_members__c, Number_of_campaigns__c  from account where Id in:accCamMap.keyset()]);
            Integer CountOfCampMember=0;
            for(Account acc : accList){
                if(accCamMap.get(acc.Id)!=null){
                    CountOfCampMember += accCamMap.get(acc.Id);
                    campaignCount += CamNumberMap.get(acc.Id);
                    system.debug('###'+campaignCount);
                }
                if(acc.Number_of_campaign_members__c==null){
                    acc.Number_of_campaign_members__c=0;
                }
                if(acc.Number_of_campaigns__c==null){
                    acc.Number_of_campaigns__c=0;
                }
                acc.Number_of_campaign_members__c += CountOfCampMember;
                system.debug('@@@'+CountOfCampMember);
                acc.Number_of_campaigns__c += campaignCount;
                system.debug('####'+campaignCount);
            }
            if(!accList.isEmpty()){
                update accList;
                system.debug('@#@#'+accList);
            }   
        }
    }  
}