trigger AccountTrigger on Account (after update) {

    if(Trigger.isAfter && Trigger.isUpdate) {
        AccountTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
    }
}