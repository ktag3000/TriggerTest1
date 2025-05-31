public with sharing class OpportunityTriggerHandler {
    
    Set<Id> opptyIds = new Set<Id>();
    
    public static void afterUpdate(List<Opportunity> newOpptyList, Map<Id, Opportunity> oldMap){
        
        for(Opportunity oppty : newOpptyList){
            Opportunity oldOpp = oldMap.get(Id);

            if (condition) {
                
            }
        }
    }
}