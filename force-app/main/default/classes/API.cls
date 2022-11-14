@RestResource(urlMapping='/AccountService/*')
global class AccountService{
@HttpGet
    global static List <Account> getAccount() {
        List <Account> acc;
        try{
acc = [SELECT Id,Name from Account];

        }
        Catch(Exception ex){
        System.debug('Error'+ ex.getMessage());
}
    return acc;
    }
} 