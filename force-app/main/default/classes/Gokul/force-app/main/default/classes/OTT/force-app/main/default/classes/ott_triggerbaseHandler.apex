public abstract class ott_triggerbaseHandler {

  public ott_triggerbaseHandler() {
    System.debug('ott_triggerbaseHandler constructor is running');  
    this.setTriggerContext();
  }

 public void run() {
    system.debug('ott_triggerbaseHandler.run is running');

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

 private void setTriggerContext() {
    this.setTriggerContext(null, false);
  }

 protected virtual void beforeInsert(){}
  
  protected virtual void beforeUpdate(){}
  
  protected virtual void beforeDelete(){}
  
  protected virtual void afterInsert(){}
  
  protected virtual void afterUpdate(){}
  
  protected virtual void afterDelete(){}
  
  protected virtual void afterUndelete(){}

   
}

  
  
  
  
  