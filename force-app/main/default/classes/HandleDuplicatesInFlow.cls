public with sharing class HandleDuplicatesInFlow {

    // Input variables for flow
    public class FlowInputs {
        @InvocableVariable
        public Id contactId;

        @InvocableVariable
        public Id accountId;
    }

    // Method called by flow
    @InvocableMethod(label='Handle Duplicate Record')
    public static void /*List<Id>*/ saveDuplicates(List<FlowInputs> inputRecords) {
        List<Id> savedIds = new List<Id>();
        System.debug('Test');

        for (FlowInputs record : inputRecords) {
            Database.DMLOptions dml = new Database.DMLOptions();
            dml.DuplicateRuleHeader.allowSave = true; // Allows the duplicate to save
            dml.DuplicateRuleHeader.runAsCurrentUser = true; // Runs with sharing context

            // Insert Contact using input variable
            if (record.contactId != null) {
                Contact con = [SELECT Id, FirstName FROM Contact WHERE Id = :record.contactId LIMIT 1];
                // Database.SaveResult srContact = Database.insert(con, dml);
                con.FirstName = con.FirstName +123;
                Database.SaveResult srContact = Database.update(con, dml);
                if (srContact.isSuccess()) {
                    savedIds.add(srContact.getId());
                    System.debug('contact success: ' +record.contactId);
                } else {
                    System.debug('contact failed: '+srContact.errors);
                }
            }
            
            // Insert Account using input variable
            if (record.accountId != null) {
                Account acc = [SELECT Id, Name FROM Account WHERE Id = :record.accountId LIMIT 1];
                // Database.SaveResult srAccount = Database.insert(acc, dml);
                acc.Name = acc.Name +123;
                Database.SaveResult srAccount = Database.update(acc, dml);
                if (srAccount.isSuccess()) {
                    savedIds.add(srAccount.getId());
                    System.debug('account success: ' +record.accountId);
                } else {
                    System.debug('account failed: ' +srAccount.errors);
                }
            }
        }
        // return savedIds;
    }
}
