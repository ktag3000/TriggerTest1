public with sharing class CaseTriggerHandler {
    
    public static void beforeInsert(List<Case> newCase){
        
        List<Case> casesNew = new List<Case>();

        // If the new case priority is high, add High Priority to the case subject
        for(Case caseUpdate : newCase) {
            if(caseUpdate.Priority == 'High'){
                caseUpdate.Subject = caseUpdate.Subject + ' - High Priority';
            }
        }
    } 
}