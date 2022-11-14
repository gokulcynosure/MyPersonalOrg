trigger AccountHandlertrigger on Account (before insert,before update,after insert,after update) {
    
OTT_TriggerBaseHandler.run('Account', Trigger.operationType , Trigger.new, Trigger.old, Trigger.newMap, Trigger.oldMap);

}