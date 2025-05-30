public with sharing class AccountTriggerHandler {
    
    public static void beforeUpdate(List<Account> newAccountList, Map<Id, Account> oldMap) {
    // Collect Account Ids
    Set<Id> accountIds = new Set<Id>();
    for (Account acc : newAccountList) {
        accountIds.add(acc.Id);
    }

    // Query open Opportunities for those Accounts
    List<Opportunity> openOpps = [
        SELECT Id, Discount_Percent__c
        FROM Opportunity 
        WHERE AccountId IN :accountIds AND IsClosed = false
    ];

    // Update discount percent
    for (Opportunity opp : openOpps) {
        System.debug('Open Opportunity: ' + opp.Id + ' with Discount %: ' + opp.Discount_Percent__c);
        
        // You can also collect or modify them if needed
    }
}

}