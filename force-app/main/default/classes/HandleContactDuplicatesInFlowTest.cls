@isTest
private class HandleContactDuplicatesInFlowTest {


@IsTest
    static void testSaveDuplicates() {
        List<SObject> inputRecords = new List<SObject>();
        // Add your input records here
        
        Test.startTest();
        List<Id> savedIds = HandleContactDuplicatesInFlow.saveDuplicates(inputRecords);
        Test.stopTest();
        
        // Add your assertions here
        System.assertEquals(0, savedIds.size(), 'Expected no saved IDs');
    }
}