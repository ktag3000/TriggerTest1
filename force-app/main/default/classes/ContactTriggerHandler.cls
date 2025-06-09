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
}