trigger EventCreate on Event__c (after insert) {
     if (Org_Specific_Setting__mdt.getInstance('Run_All_Triggers')?.Value__c == true) {
        TriggerHandler handler = new EventTriggerHandler(Trigger.isExecuting, Trigger.size);
        switch on Trigger.operationType {
             when AFTER_INSERT {
                 handler.afterInsert(Trigger.new, Trigger.newMap);
            }

}
     }
}