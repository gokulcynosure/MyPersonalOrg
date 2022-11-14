public with sharing abstract class OTT_TriggerBaseHandler {
    private TriggerContext context;
   private Boolean isTriggerExecuting;
   public Boolean isTriggerActive(){
       return Trigger_Context__c.getInstance().Is_Active__c;
   }
   /*public static OTT_TriggerBaseHandler handlerObj;
   public static  OTT_TriggerBaseHandler run(){
       if(handlerObj==null){
           handlerObj.execute();
       }
       else{
           handlerObj.recursive();
       }
       return handlerObj;
   }
   private void recursive(){
       handlerObj.execute();
       OTT_TriggerBaseHandler.handlerObj=this;
   }
   */
   
   private void execute(){
       if(isTriggerActive()==TRUE){
           this.setTriggerContext();
       }
       else{
           return;
           
       }
   }
    private void setTriggerContext() {
   if((Trigger.isExecuting && Trigger.isBefore && Trigger.isInsert)) 
        {
     this.context = TriggerContext.BEFORE_INSERT;
   } else if((Trigger.isExecuting && Trigger.isBefore && Trigger.isUpdate)){
     this.context = TriggerContext.BEFORE_UPDATE;
   } else if((Trigger.isExecuting && Trigger.isBefore && Trigger.isDelete)) {
     this.context = TriggerContext.BEFORE_DELETE;
   } else if((Trigger.isExecuting && Trigger.isAfter && Trigger.isInsert)) {
     this.context = TriggerContext.AFTER_INSERT;
   } else if((Trigger.isExecuting && Trigger.isAfter && Trigger.isUpdate)) {
     this.context = TriggerContext.AFTER_UPDATE;
   } else if((Trigger.isExecuting && Trigger.isAfter && Trigger.isDelete)) {
     this.context = TriggerContext.AFTER_DELETE;
   } else if((Trigger.isExecuting && Trigger.isAfter && Trigger.isUndelete)) {
     this.context = TriggerContext.AFTER_UNDELETE;
   }
         switch on this.context {
        when BEFORE_INSERT {
       this.beforeInsert();
     }
     when BEFORE_UPDATE {
       this.beforeUpdate();
     }
     when BEFORE_DELETE {
       this.beforeDelete();
     }
     when AFTER_INSERT {
       this.afterInsert();
     }
     when AFTER_UPDATE {
       this.afterUpdate();
     }
     when AFTER_DELETE {
       this.afterDelete();
     }
     when AFTER_UNDELETE {
       this.afterUndelete();
     }
         }
    }
    protected virtual void beforeInsert(){}
  
    protected virtual void beforeUpdate(){}
    
    protected virtual void beforeDelete(){}
    
    protected virtual void afterInsert(){}
    
    protected virtual void afterUpdate(){}
    
    protected virtual void afterDelete(){}
    protected virtual void afterUndelete(){}
    private enum TriggerContext {
   BEFORE_INSERT, BEFORE_UPDATE, BEFORE_DELETE,
   AFTER_INSERT, AFTER_UPDATE, AFTER_DELETE,
   AFTER_UNDELETE
 }
}