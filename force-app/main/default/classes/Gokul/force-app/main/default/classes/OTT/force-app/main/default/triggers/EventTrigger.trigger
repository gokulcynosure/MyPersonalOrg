trigger eventTrigger on Event__c(after insert){
    System.System.debug('Event trigger is running');
    new EventTriggerHandler().run();
    
}