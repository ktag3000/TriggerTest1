public with sharing class AccountTriggerHandler {
    
    public static void beforeUpdate(List<Account> newAccountList, Map<Id, Account> oldMap) {
    Set<Id> changedToChurchAccountIds = new Set<Id>();

    // Identify Accounts whose Industry changed to "Church"
    for (Account acc : newAccountList) {
        Account oldAcc = oldMap.get(acc.Id);

        if (acc.Industry != oldAcc.Industry && acc.Industry == 'Church') {
            changedToChurchAccountIds.add(acc.Id);
        }
    }

    // Query related open Opportunities
    if (!changedToChurchAccountIds.isEmpty()) {
        List<Opportunity> openOpps = [
            SELECT Id, Name, Discount_Percent__c
            FROM Opportunity
            WHERE AccountId IN :changedToChurchAccountIds AND IsClosed = false
        ];

        // Update discount percent
        for (Opportunity opp : openOpps) {
            System.debug('Church Account Opportunity: ' + opp.Name);
            opp.Discount_Percent__c = 10;
        } update openOpps;
    }
}


}