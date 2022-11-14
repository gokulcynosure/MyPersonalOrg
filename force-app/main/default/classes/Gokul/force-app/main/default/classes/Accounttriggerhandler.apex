public class Accounttriggerhandler{
    public static void insertContact(List<Account>accList){
        List<Contact>conList=new List<Contact>();
        for(Account acc:accList){
            Contact con=new Contact();
            con.lastname=acc.name;
            con.phone=acc.phone;
            con.accountid=acc.id;
            conList.add(con);
        }
        if(contactList.size()>0){
            insert contactList;
        }
    }
}