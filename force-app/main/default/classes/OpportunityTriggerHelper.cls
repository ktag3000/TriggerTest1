public with sharing class OpportunityTriggerHelper {
    
    //======================
    // After update
    //=======================

    // Reassign Oppty files to Account when closed
    //============================================
    // TODO handle exception is query does not return results
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
        Set<Id> contentDocIds = new Set<Id>();

        if(!opptyIds.isEmpty()) {
            for(List<ContentDocumentLink> cDL : [
                Select Id, ContentDocumentId, LinkedEntityId, ShareType, Visibility
                FROM ContentDocumentLink
                WHERE LinkedEntityId IN :opptyIds
            ]){
                System.debug('Content document query: ' +cDL);
                // contentDocIds.add(cDL);
            }
        } 
        System.debug('contentDocIds: ' +contentDocIds);

        // Assign variables to create CDL on Account

    } // insert account
}