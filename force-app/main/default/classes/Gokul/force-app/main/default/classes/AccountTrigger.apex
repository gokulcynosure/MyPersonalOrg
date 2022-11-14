trigger AccountTrigger on Account(after insert){
    if(trigger.isInsert&&trigger.isAfter){
        Accounttriggerhandler.insertContact(trigger.new);
    }
}