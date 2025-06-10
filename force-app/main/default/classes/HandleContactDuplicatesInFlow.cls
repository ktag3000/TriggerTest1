public with sharing class HandleContactDuplicatesInFlow {
    @InvocableMethod(label='Handle Duplicate Record') // Allows to be called in flow and set the name

    // Returns a List<Id> from the saveDuplicates method. Takes an input of a List<SObject> inputRecords
    public static List<Id> saveDuplicates(List<SObject> inputRecords){ 
        List<Id> savedIds = new List<Id>();
        
        // 
        for(SObject record : inputRecords){
            Database.DMLOptions dml = new Database.DMLOptions();
            System.debug('dml: ' +dml);
            dml.DuplicateRuleHeader.allowSave = true;
            dml.DuplicateRuleHeader.runAsCurrentUser = true;
            
            record.setOptions(dml);

            Database.SaveResult sr = Database.insert(record, dml);
                if(sr.isSuccess()){
                    savedIds.add(sr.getId());
                    System.debug('Duplicate updated successfully!');
                    System.debug('dml: ' +dml);
                }

        }
        System.debug('savedIds: ' +savedIds);
        return savedIds;
    }
}

/* 
Database.DMLOptions dml = new Database.DMLOptions(); 
dml.DuplicateRuleHeader.allowSave = true;
dml.DuplicateRuleHeader.runAsCurrentUser = true;
Account duplicateAccount = new Account(Name='dupe');
Database.SaveResult sr = Database.insert(duplicateAccount, dml);
if (sr.isSuccess()) {
	System.debug('Duplicate account has been inserted in Salesforce!');
}
*/