@isTest
private class HandleDuplicatesInFlowTest {

    @isTest
    static void testSaveDuplicates_withBothContactAndAccount() {
        // Create test Contact
        Contact testContact = new Contact(FirstName = 'Test', LastName = 'User');
        insert testContact;

        // Create test Account
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Create flow input
        HandleDuplicatesInFlow.FlowInputs input = new HandleDuplicatesInFlow.FlowInputs();
        input.contactId = testContact.Id;
        input.accountId = testAccount.Id;

        List<HandleDuplicatesInFlow.FlowInputs> inputList = new List<HandleDuplicatesInFlow.FlowInputs>{input};

        Test.startTest();
        HandleDuplicatesInFlow.saveDuplicates(inputList);
        Test.stopTest();

        // Confirm records still exist (implies update didn't fail)
        Contact updatedContact = [SELECT Id FROM Contact WHERE Id = :testContact.Id];
        System.assertNotEquals(null, updatedContact, 'Contact should still exist after update');

        Account updatedAccount = [SELECT Id FROM Account WHERE Id = :testAccount.Id];
        System.assertNotEquals(null, updatedAccount, 'Account should still exist after update');
    }

    @isTest
    static void testSaveDuplicates_withOnlyContact() {
        Contact testContact = new Contact(FirstName = 'Only', LastName = 'Contact');
        insert testContact;

        HandleDuplicatesInFlow.FlowInputs input = new HandleDuplicatesInFlow.FlowInputs();
        input.contactId = testContact.Id;

        Test.startTest();
        HandleDuplicatesInFlow.saveDuplicates(new List<HandleDuplicatesInFlow.FlowInputs>{input});
        Test.stopTest();

        Contact updatedContact = [SELECT Id FROM Contact WHERE Id = :testContact.Id];
        System.assertNotEquals(null, updatedContact);
    }

    @isTest
    static void testSaveDuplicates_withOnlyAccount() {
        Account testAccount = new Account(Name = 'Only Account');
        insert testAccount;

        HandleDuplicatesInFlow.FlowInputs input = new HandleDuplicatesInFlow.FlowInputs();
        input.accountId = testAccount.Id;

        Test.startTest();
        HandleDuplicatesInFlow.saveDuplicates(new List<HandleDuplicatesInFlow.FlowInputs>{input});
        Test.stopTest();

        Account updatedAccount = [SELECT Id FROM Account WHERE Id = :testAccount.Id];
        System.assertNotEquals(null, updatedAccount);
    }
}

