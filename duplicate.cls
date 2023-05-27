/*-------------------------------------------------------------------------------------------
Name:       duplicate.cls
Purpose:    An Apex class for custom duplicate records logic.
------------------------------History--------------------------------------------------------
Version     Author                Date                 Detail Description 
-------     ---------------       --------------       ------------------
1.0         Sourabh Naik          20th Feb 2023        Initial Development 
--------------------------------------------------------------------------------------------*/
public with sharing class duplicate {

    /*
     * Method Name : duplicateRecordA
     * Return Type : boolean
     * Parameters : String of Account ID
     * Description : This method is used in LWC for the custom duplicate account record logic.
     * */
    @AuraEnabled(cacheable = true)
    public static boolean duplicateRecordA(String idString){
        try {
            list<Account> paraCon1 = [SELECT BillingState, Website, Name FROM Account WHERE id =: idString];

            Datacloud.FindDuplicatesResult[] results = Datacloud.Findduplicates.findDuplicates(paraCon1);
            for (Datacloud.FindDuplicatesResult findDupeResult : results) {
                for (Datacloud.DuplicateResult dupeResult : findDupeResult.getDuplicateResults()) {
                    for (Datacloud.matchResult matchResult : dupeResult.getMatchResults()) {
                        for (Datacloud.MatchRecord matchRecord : matchResult.getMatchRecords()) {
                            return true;
                        }
                    }
                }
            }
            return false;
        } catch (Exception e) {
            System.debug('An Exception: '+e);
            return false;
        }
    }
}