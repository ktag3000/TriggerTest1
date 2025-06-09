public with sharing class ContactTriggerHandler {
    
    //===============
    // Before insert
    //===============

    // Capitalize first and last names
    public static void capitalizeNames(List<Contact> newContacts){
        System.debug('Test capitalizeNames(): ' +newContacts);

        for(Contact cont : newContacts){
            // cont.FirstName.capitalize();
            cont.FirstName = cont.FirstName.toString().capitalize();
            cont.LastName = cont.LastName.capitalize();
        }
    }

    // Match new Contact's industry to related Account
    public static void contactIndustry(List<Contact> newContacts){
        System.debug('Test contactIndustry(): ' +newContacts);

        // Get the related Accounts
        Set<Account> accIds = new Set<Account>();
        
        for(Account acc : [
            SELECT Id, FirstName, LastName, Industry__c, AccountId, Account.Name
            FROM Contact
            WHERE Id IN :newContacts
            ]){
                // accIds.add(acc);
                System.debug('test query' +acc);
            }
            // System.debug('accIds:' +accIds);

            // Check if Contact industry is blank or matches the related Account
            
        }   
}