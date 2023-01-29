/*-------------------------------------------------------------------------------------------
Name:       duplicate.cls
Purpose:    An Apex class for custom duplicate contact records logic.
------------------------------History--------------------------------------------------------
Version     Author                Date                 Detail Description 
-------     ---------------       --------------       ------------------
1.0         Sourabh Naik          29th Jan 2023        Initial Development 
--------------------------------------------------------------------------------------------*/
public with sharing class duplicate {

    /*
     * Method Name : duplicateContact
     * Return Type : boolean
     * Parameters : String of Contact ID
     * Description : This method is used in LWC for the custom duplicate contact logic.
     * */
    @AuraEnabled(cacheable = true)
    public static boolean duplicateContact(String ConId){
        try {
            list<Contact> paraCon = [SELECT Email, FirstName, LastName FROM Contact WHERE id =: ConId];
            String emailVar, Fname, Lname;
            for(Contact con : paraCon) {
                emailVar = con.Email;
                Fname = con.FirstName;
                Lname = con.LastName;
            }
            list<Contact> Lcon = new List<Contact>();
            if(emailVar == NULL && Fname != NULL && Lname != NULL){
                Lcon = [SELECT Id FROM Contact WHERE FirstName =: Fname OR LastName =: Lname LIMIT 2];
            }
            if(Fname == NULL && emailVar != NULL && Lname != NULL){
                Lcon = [SELECT Id FROM Contact WHERE Email =: emailVar OR LastName =: Lname LIMIT 2];
            }
            if(emailVar == NULL && Fname == NULL && Lname != NULL){
                Lcon = [SELECT Id FROM Contact WHERE LastName =: Lname LIMIT 2];
            }
            if(Fname != NULL && emailVar != NULL && Lname != NULL){
                Lcon = [SELECT Id FROM Contact WHERE Email =: emailVar OR FirstName =: Fname OR LastName =: Lname LIMIT 2];
            }     
            if(Lcon.size()>1){
                return true;
            }
            return false;
        } catch (Exception e) {
            System.debug('An Exception: '+e);
            return false;
        }
    }
}