trigger CaseTrigger on Case (before insert, after update) {
    
    if (Trigger.isInsert && Trigger.isBefore){
        CaseTriggerHandler.beforeInsert(Trigger.new);
    }

    if(Trigger.isUpdate && Trigger.isAfter){
        CaseTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
    }
}