public with sharing class AccountTriggerHandler {
    
    public static void afterUpdate(List<Account> newAccountList, Map<Id, Account> oldMap){
        AccountTriggerHelper.updateOpptyDiscount(newAccountList, oldMap);
    }   
}