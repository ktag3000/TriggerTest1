@isTest
private class HandleDuplicatesInFlowTest {

    @isTest
    static void testSaveDuplicates_withContactAndAccount() {
        // Create test Contact
        Contact testContact = new Contact(FirstName = 'John', LastName = 'Doe');
        insert testContact;

        // Create test Account
        Account testAccount = new Account(Name = 'Acme Inc');
        insert testAccount;

        // Prepare input for the invocable method
        HandleDuplicatesInFlow.FlowInputs input = new HandleDuplicatesInFlow.FlowInputs();
        input.contactId = testContact.Id;
        input.accountId = testAccount.Id;

        List<HandleDuplicatesInFlow.FlowInputs> inputList = new List<HandleDuplicatesInFlow.FlowInputs>{input};

        Test.startTest();
        HandleDuplicatesInFlow.saveDuplicates(inputList);
        Test.stopTest();

        // Verify the updates happened
        Contact updatedContact = [SELECT FirstName FROM Contact WHERE Id = :testContact.Id];
        System.assert(updatedContact.FirstName.contains('123'), 'Contact FirstName should be updated');

        Account updatedAccount = [SELECT Name FROM Account WHERE Id = :testAccount.Id];
        System.assert(updatedAccount.Name.contains('123'), 'Account Name should be updated');
    }

    @isTest
    static void testSaveDuplicates_withOnlyContact() {
        // Create test Contact
        Contact testContact = new Contact(FirstName = 'Jane', LastName = 'Smith');
        insert testContact;

        // Prepare input with only contactId
        HandleDuplicatesInFlow.FlowInputs input = new HandleDuplicatesInFlow.FlowInputs();
        input.contactId = testContact.Id;

        List<HandleDuplicatesInFlow.FlowInputs> inputList = new List<HandleDuplicatesInFlow.FlowInputs>{input};

        Test.startTest();
        HandleDuplicatesInFlow.saveDuplicates(inputList);
        Test.stopTest();

        // Verify contact update
        Contact updatedContact = [SELECT FirstName FROM Contact WHERE Id = :testContact.Id];
        System.assert(updatedContact.FirstName.contains('123'), 'Contact FirstName should be updated');
    }

    @isTest
    static void testSaveDuplicates_withOnlyAccount() {
        // Create test Account
        Account testAccount = new Account(Name = 'Tech Corp');
        insert testAccount;

        // Prepare input with only accountId
        HandleDuplicatesInFlow.FlowInputs input = new HandleDuplicatesInFlow.FlowInputs();
        input.accountId = testAccount.Id;

        List<HandleDuplicatesInFlow.FlowInputs> inputList = new List<HandleDuplicatesInFlow.FlowInputs>{input};

        Test.startTest();
        HandleDuplicatesInFlow.saveDuplicates(inputList);
        Test.stopTest();

        // Verify account update
        Account updatedAccount = [SELECT Name FROM Account WHERE Id = :testAccount.Id];
        System.assert(updatedAccount.Name.contains('123'), 'Account Name should be updated');
    }
}
