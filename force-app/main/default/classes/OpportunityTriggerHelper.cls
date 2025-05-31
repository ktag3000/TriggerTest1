public with sharing class OpportunityTriggerHelper {
    
    //======================
    // After update
    //=======================

    // TODO new idea. When an opp is closed won, mark the related account rating hot.

    // Reassign Oppty files to Account when closed
    //============================================
    // TODO handle exception is query does not return results
    public static void reassignOpptyFiles(List<Opportunity> newOpptyList, Map<Id, Opportunity> oldMap){

        Set<Id> opptyIds = new Set<Id>(); // Declare the set to hold the oppty id from the trigger

        // Loop over newOpptyList input with criteria
        for(Opportunity opp : newOpptyList){
            Opportunity oldOppty = oldMap.get(opp.id);

            if(opp.StageName == 'Closed Lost' && oldOppty.StageName != opp.StageName){
                opptyIds.add(opp.Id);
            }
        }

        // If oppty id's are found then continue with querying the related files (CDL)
        Set<Id> contentDocIds = new Set<Id>();

        // Query CDL's for triggering oppty
        if(!opptyIds.isEmpty()) {
            List<ContentDocumentLink> opptyCDL = [
                Select Id, ContentDocumentId, LinkedEntityId, ShareType, Visibility
                FROM ContentDocumentLink
                WHERE LinkedEntityId IN :opptyIds
            ];
        
        // Assign CDL's to account and insert
        List<ContentDocumentLink> accUpdate = new List<ContentDocumentLink>();    
        for(ContentDocumentLink cDL : opptyCDL){
            Id accLinkedEntityId = cDL.LinkedEntityId;
            System.debug('acclinkedentityid: ' +accLinkedEntityId);
        }
    //   insert accUpdate;  
        } 
    } 
}