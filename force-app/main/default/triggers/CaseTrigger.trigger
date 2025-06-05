trigger CaseTrigger on Case (before insert) {
    
    if (Trigger.isInsert && Trigger.isBefore){
        CaseTriggerHandler.beforeInsert(Trigger.new);
    }
}