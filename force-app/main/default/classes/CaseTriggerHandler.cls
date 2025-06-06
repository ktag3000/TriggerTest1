public with sharing class CaseTriggerHandler {
    
    //===============
    // Before Insert
    //===============
    public static void beforeInsert(List<Case> newCase){
        
        List<Case> casesNew = new List<Case>();

        // If the new case priority is high, add High Priority to the case subject
        for(Case caseUpdate : newCase) {
            if(caseUpdate.Priority == 'High'){
                caseUpdate.Subject = caseUpdate.Subject + ' - High Priority';
            }
        }
    } 

    //===============
    // After Update
    //===============
    public static void afterUpdate(List<Case> newCase, Map<Id, Case> oldMap){
        // TODO create field on the Account to hold the total number of closed cases
        // When a case is closed this method will update that number by 1
    }
}