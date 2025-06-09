trigger AccountTrigger on Account (before insert, after update) {

    // Before insert
    if(Trigger.isBefore && Trigger.isInsert){
        AccountTriggerHandler.beforeInsert(Trigger.new);
        System.debug('Account trigger before insert');
    }
    
    // After update
    if(Trigger.isAfter && Trigger.isUpdate) {
        AccountTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
        System.debug('Account trigger after update');
    }
}