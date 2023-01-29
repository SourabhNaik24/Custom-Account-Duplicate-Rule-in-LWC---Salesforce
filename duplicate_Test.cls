/*-------------------------------------------------------------------------------------------
Name:       duplicate_Test.cls
Purpose:    Test class for duplicate.cls.
------------------------------History--------------------------------------------------------
Version     Author                Date                 Detail Description 
-------     ---------------       --------------       ------------------
1.0         Sourabh Naik          29th Jan 2023        Initial Development 
--------------------------------------------------------------------------------------------*/
@IsTest
public class duplicate_Test {

    // This method is for when you don't have any record matching the duplicate criteria
    @IsTest
    public static void duplicate_Test1() {
        Contact con1 = new Contact();
        con1.FirstName = 'First';
        con1.LastName = 'Last';
        con1.Email = 'firstlast@gmail.com';
        insert con1;

        Test.startTest();
        duplicate.duplicateContact(con1.id);
        Test.stopTest();
    }

    // This method is for when you have duplicate record matching all 3 fields in the duplicate criteria
    @IsTest
    public static void duplicate_Test2() {
        Contact con1 = new Contact();
        con1.FirstName = 'First';
        con1.LastName = 'Last';
        con1.Email = 'firstlast@gmail.com';
        insert con1;

        Contact con2 = new Contact();
        con2.FirstName = 'First';
        con2.LastName = 'Last';
        con2.Email = 'firstlast@gmail.com';
        insert con2;

        Test.startTest();
        duplicate.duplicateContact(con1.id);
        Test.stopTest();
    }

    // This method is for when you have duplicate record (LastName and FirstName) matching the duplicate criteria
    @IsTest
    public static void duplicate_Test3() {
        Contact con1 = new Contact();
        con1.FirstName = 'First';
        con1.LastName = 'Last';
        insert con1;

        Contact con2 = new Contact();
        con2.FirstName = 'First';
        con2.LastName = 'Last';
        insert con2;

        Test.startTest();
        duplicate.duplicateContact(con1.id);
        Test.stopTest();
    }

    // This method is for when you have duplicate record (LastName and Email) matching the duplicate criteria
    @IsTest
    public static void duplicate_Test4() {
        Contact con1 = new Contact();
        con1.LastName = 'Last';
        con1.Email = 'firstlast@gmail.com';
        insert con1;

        Contact con2 = new Contact();
        con2.Email = 'firstlast@gmail.com';
        con2.LastName = 'Last';
        insert con2;

        Test.startTest();
        duplicate.duplicateContact(con1.id);
        Test.stopTest();
    }

    // This method is for when you have duplicate record (LastName) matching the duplicate criteria
    @IsTest
    public static void duplicate_Test5() {
        Contact con1 = new Contact();
        con1.LastName = 'Last';
        insert con1;

        Contact con2 = new Contact();
        con2.LastName = 'Last';
        insert con2;

        Test.startTest();
        duplicate.duplicateContact(con1.id);
        Test.stopTest();
    }
}
