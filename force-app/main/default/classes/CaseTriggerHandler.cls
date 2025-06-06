public with sharing class CaseTriggerHandler {
    
    //===============
    // Before Insert
    //===============
    public static void beforeInsert(List<Case> newCases){

        // If the new case priority is high, add High Priority to the case subject
        for(Case caseUpdate : newCases) {
            if(caseUpdate.Priority == 'High'){
                caseUpdate.Subject = caseUpdate.Subject + ' - High Priority';
            }
        }
    } 

    //===============
    // After Update
    //===============
    public static void afterUpdate(List<Case> newCases, Map<Id, Case> oldMap){
        
        // Get related accounts
        Set<Id> accIds = new Set<Id>();

        for(Case c : newCases){
            Case oldCases = oldMap.get(c.Id);
            if(c.AccountId != null && c.IsClosed == true && c.IsClosed != oldCases.IsClosed){
                accIds.add(c.AccountId);
            }
        }
        
        System.debug('accIds: ' +accIds);

        if(!accIds.isEmpty()){
            Account accountsToUpdate;
            for(Account acc : [
                SELECT Id, Name, Closed_Case_Count__c
                FROM Account
                WHERE Id IN :accIds
            ]){
                if(acc.Closed_Case_Count__c == null){
                    acc.Closed_Case_Count__c = 1;
                    accountsToUpdate = acc;
                } else{
                    acc.Closed_Case_Count__c ++;
                    accountsToUpdate = acc;
                }
            }
            update accountsToUpdate;
        }
    }
}