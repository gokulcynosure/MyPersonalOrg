public without sharing class EventTriggerHelper {
    public EventTriggerHelper() {
        System.debug('Inside EventTriggerHelper Constructor');
    }
     public static void eventCreation(List<Event__c>eveList){
        List<Account>accountlist=new List<Account>();
        for(Event__c eve:eveList){
            Account acc=new Account();
            acc.LastName=eve.Name;
            //con.phone=acc.phone;
            //con.accountid=acc.id;
            accountList.add(acc);
        }
        if(accountList.size()>0){
            insert accountList;
        }
    }

}