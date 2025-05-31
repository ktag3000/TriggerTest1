public with sharing class OpportunityTriggerHelper {
    
    public static void reassignOpptyFiles(List<Opportunity> newOpptyList, Map<Id, Opportunity> oldMap){

        Set<Id> opptyIds = new Set<Id>(); // Declare the set to hold the oppty id from the trigger

        // Loop over newOpptyList input with criteria
        for(Opportunity opp : newOpptyList){
            Opportunity oldOppty = oldMap.get(opp.id);
            System.debug(oldOppty);

            if(opp.StageName == 'Closed Lost' && oldOppty.StageName != opp.StageName){
                opptyIds.add(opp.Id);
            }
        }

        // If oppty id's are found then continue with querying the related files (CDL)
        if(!opptyIds.isEmpty()) {
            List<ContentDocumentLink> contentDocLinkList = [
                Select Id, ContentDocumentId, LinkedEntityId, ShareType, Visibility
                FROM ContentDocumentLink
                WHERE LinkedEntityId IN :opptyIds
            ];
        }

        // Assign variables to create CDL on Account
        if(!contentDocLinkList.isEmpty()){
            for(ContentDocumentLink cdl : contentDocLinkList){
                Id accContentDocumentId = cdl.ContentDocumentId;
                Id accLinkedEntityId = cdl.LinkedEntityId;
                String accShareType = cdl.ShareType;
                String accVisibility = cdl.Visibility;
            }
        }

    }
}