public with sharing class AccountTriggerHandler {

    // Before insert
    public static void beforeInsert(List<Account> newAccountList){
        AccountTriggerHelper.accountType(newAccountList);
        System.debug('Before insert AccountTriggerHandler');
    }
    
    // After update
    public static void afterUpdate(List<Account> newAccountList, Map<Id, Account> oldMap){
        AccountTriggerHelper.updateOpptyDiscount(newAccountList, oldMap);
        System.debug('After update AccountTriggerHandler');
    }   
}