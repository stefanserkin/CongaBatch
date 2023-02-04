public class OppAcknowledgmentsListViewCtrl {

    private final static String urlFieldName = 'Donation_Acknowledgment__c';
    private String partnerServerUrl;
    private ApexPages.StandardSetController controller;
    private List<Id> recordIds = new List<Id>();
  
    public OppAcknowledgmentsListViewCtrl(ApexPages.StandardSetController controller) {
        this.controller = controller;
        for (sObject sObj : controller.getSelected()){
            recordIds.add(sObj.Id);
        }
        partnerServerUrl = System.URL.getOrgDomainUrl().toExternalForm()+'/services/Soap/u/56.0/'+UserInfo.getOrganizationId();
    }
  
    public PageReference prepareBatchUrl() {
        PageReference batchUrl = new PageReference('https://conductor.congamerge.com?');
        batchUrl.getParameters().put('MOID', String.join(new List<Id>(recordIds),','));
        batchUrl.getParameters().put('SessionId',  UserInfo.getSessionID());
        batchUrl.getParameters().put('ServerUrl',  partnerServerUrl);
        batchUrl.getParameters().put('UrlFieldName',  urlFieldName);
        return batchUrl;
    }

}