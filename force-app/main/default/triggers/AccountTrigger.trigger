trigger AccountTrigger on Account (before update) {

    if(Trigger.isAfter && Trigger.isUpdate) {
        AccountTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
    }
}