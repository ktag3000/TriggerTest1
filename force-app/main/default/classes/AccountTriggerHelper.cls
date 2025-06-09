public with sharing class AccountTriggerHelper {
    
    //================
    // Before Insert
    //================

    // Set default Account Type to Customer - Direct if it's blank
    public static void accountType(List<Account> newAccountList){
        System.debug('Test accountType()');
        System.debug('accountType() newAccountList: ' +newAccountList); 

        // Check if the current item in the loop has a blank Type field
        for(Account acc : newAccountList){
            if(acc.Type == null){
                acc.Type = 'Customer - Direct';
            }
        }

    }

    //=============================
    // After update 
    //=============================

    // Identify Accounts whose Industry changed to "Church"
    //======================================================
    // TODO handle exception is query does not return results
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