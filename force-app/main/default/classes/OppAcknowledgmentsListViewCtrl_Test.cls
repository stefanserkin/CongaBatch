/**
* @description Test Class for the ConductorFromListViewController Class
*/

@isTest
private class OppAcknowledgmentsListViewCtrl_Test {

    /**
    * @description setup - test data setup method
    */
    @testSetup
    static void makeData(){
        List<Account> testAccounts = new List<Account>();

        Account a = new Account();
        a.Name = 'ABC Company, Inc.';
        testAccounts.add(a);

        Account acct = new Account();
        acct.Name = 'XYZ Company, Inc.';
        testAccounts.add(acct);

        insert testAccounts;
    }

    /**
    * @description testControllerUrl - Test Happy Path of code
    */
    @isTest
    static void testControllerUrl() {
        List<sObject> accts = (List<Account>)[Select Id From Account];
        System.debug(accts);
        ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(accts);
        ssc.setSelected(accts);
        OppAcknowledgmentsListViewCtrl lvc = new OppAcknowledgmentsListViewCtrl(ssc);
        lvc.prepareBatchUrl();
        Test.startTest();
        PageReference pr = lvc.prepareBatchUrl();
        String fieldName = pr.getParameters().get('UrlFieldName');
        System.assertEquals(
            'Donation_Acknowledgment__c',
            fieldName, 
            'The UrlFieldName parameter is not set' 
        );
        Test.stopTest();
    }

}