@RestResource(urlMapping='/PutAPI/*')
global with sharing class ContactResource {
    
    @HTTPPut
    global static Account upsertContact(String Phone) {
        
        RestRequest AccountRequest = RestContext.request;
     
        String AccountRequestURI = AccountRequest.requestURI;
        
        String AccountId = AccountRequestURI.substring(AccountRequestURI.lastIndexOf('/') + 1);
       
        Account account = new Account();
        
        if(String.isNotEmpty(accountId)) {
            account.Id = accountId;
        }
        Account.Phone = Phone;
       
        upsert Account;
        
        return Account;
    }
}