public with sharing class CaseTriggerHandler {
    
    public static void beforeInsert(List<Case> newCase){
        
        List<Case> casesNew = new List<Case>();

        for(Case caseUpdate : newCase) {
            
            if(caseUpdate.Priority == 'High'){
                caseUpdate.Subject = caseUpdate.Subject + ' - High Priority';
            }
        }
    } 
}