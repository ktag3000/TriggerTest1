public with sharing class AccountTriggerHelper {
    
    //=============================
    // After update methods
    //=============================

    // Identify Accounts whose Industry changed to "Church"
    //======================================================
    public static void updateOpptyDiscount(List<Account> newAccountList, Map<Id, Account> oldMap){
        Set<Id> accountIds = new Set<Id>();
    
        for (Account acc : newAccountList) {
            Account oldAcc = oldMap.get(acc.Id);

            if (acc.Industry != oldAcc.Industry && acc.Industry == 'Church') {
                accountIds.add(acc.Id);
            }
        }

        // Query related open Opportunities
        if (!accountIds.isEmpty()) {
            List<Opportunity> openOpps = [
                SELECT Id, Name, Discount_Percent__c
                FROM Opportunity
                WHERE AccountId IN :accountIds AND IsClosed = false
            ];

            // Update discount percent
            for (Opportunity opp : openOpps) {
                System.debug('Church Account Opportunity: ' + opp.Name);
                if(opp.Discount_Percent__c < 10 || opp.Discount_Percent__c == null){
                    opp.Discount_Percent__c = 10;
                }
                System.debug('Opp discount: ' +opp.Discount_Percent__c);
            } update openOpps;
        }
    }
}