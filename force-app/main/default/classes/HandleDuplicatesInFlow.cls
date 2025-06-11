public with sharing class HandleDuplicatesInFlow {

    // Input variables for flow
    public class FlowInputs {
        @InvocableVariable
        public Id contactId;

        @InvocableVariable
        public Id accountId;
    }

    // 
    @InvocableMethod(label='Handle Duplicate Record')
    public static List<Id> saveDuplicates(List<FlowInputs> inputRecords) {
        List<Id> savedIds = new List<Id>();

        for (FlowInputs record : inputRecords) {
            Database.DMLOptions dml = new Database.DMLOptions();
            dml.DuplicateRuleHeader.allowSave = true; // Allows the duplicate to save
            dml.DuplicateRuleHeader.runAsCurrentUser = true; // Runs with sharing context

            // Insert Contact using input variable
            if (record.contactId != null) {
                Contact con = [SELECT Id, FirstName, LastName, Email, AccountId FROM Contact WHERE Id = :record.contactId LIMIT 1];
                Database.SaveResult srContact = Database.insert(con, dml);
                if (srContact.isSuccess()) {
                    savedIds.add(srContact.getId());
                }
            }

            // Insert Account using input variable
            if (record.accountId != null) {
                Account acc = [SELECT Id, Name FROM Account WHERE Id = :record.accountId LIMIT 1];
                Database.SaveResult srAccount = Database.insert(acc, dml);
                if (srAccount.isSuccess()) {
                    savedIds.add(srAccount.getId());
                }
            }
        }

        return savedIds;
    }
}
