@RestResource(urlMapping='/api/Account12/*')
global with sharing class MyFirstRestAPIClass
{
    @HttpGet
    global static List <Account> getAccount() {
        List <Account> acc;
       

        acc = [SELECT Id,Name from Account];

        return acc;
   

}
}