// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

// List<Case> delCase = [select id from case where subject like '%test%'];
List<Contact> del = [select id, firstname, lastname from contact where firstname like '%test%' or lastname like '%test%'];

system.debug(del);
delete del;