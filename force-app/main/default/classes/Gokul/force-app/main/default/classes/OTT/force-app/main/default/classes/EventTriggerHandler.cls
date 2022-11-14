public without sharing class EventTriggerHandler implements TriggerHandler {
    private boolean triggerIsExecuting;
    private integer triggerSize;
    public EventTriggerHelper helper;
    public EventTriggerHandler(boolean triggerIsExecuting, integer triggerSize) {
        this.triggerIsExecuting = triggerIsExecuting;
        this.triggerSize = triggerSize;
        this.helper = new EventTriggerHelper();
        
    }
     public void afterInsert(List<Event__c> newAccounts, Map<ID, SObject> neweventMap) {
         helper.eventCreation();

}
}