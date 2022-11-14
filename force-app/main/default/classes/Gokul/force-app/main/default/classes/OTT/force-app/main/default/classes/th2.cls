public class eventtriggerhandler1 {

    public static void insertContact(List<Event__c>accList){
        List<Account>conList=new List<Account>();
        for(Event__c acc:accList){
            Account con=new Account();
            con.lastname=acc.name;
           // con.phone=acc.phone;
            //con.accountid=acc.id;
            conList.add(con);
        }
        if(conList.size()>0){
            insert conList;
        }
    }
}