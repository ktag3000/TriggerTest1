// Use your actual Contact Id here
Id contactId = '003bm00000LHaPZAA1';

// Prepare FlowInputs with only ContactId
HandleContactDuplicatesInFlow.FlowInputs input = new HandleContactDuplicatesInFlow.FlowInputs();
input.contactId = contactId;

// Add to list
List<HandleContactDuplicatesInFlow.FlowInputs> inputs = new List<HandleContactDuplicatesInFlow.FlowInputs>{input};

// Call method
List<Id> result = HandleContactDuplicatesInFlow.saveDuplicates(inputs);

// Output result
System.debug('Saved IDs: ' + result);
