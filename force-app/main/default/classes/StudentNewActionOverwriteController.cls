public with sharing class StudentNewActionOverwriteController {
    public Student__c newStudentObject {get;set;}
    public Parent__c motherRecord {get;set;}
    public Parent__c fatherRecord {get;set;}
    public Decimal motherAdhaarNumber {get;set;}
    public Decimal fatherAdhaarNumber {get;set;}
    public String motherOccupation {get;set;}
    public String fatherOccupation {get;set;}
    public Boolean bothParentsAdharNumbersWrong {get;set;}
    public Boolean oneParentAdharNumberWrong {get;set;}
    public Boolean motherInformationMissing {get;set;}
    public Boolean fatherInformationMissing {get;set;}
    public Boolean discountNotValid {get;set;}
    
    public StudentNewActionOverwriteController(ApexPages.StandardController cosntroller) {
        initVariables();
        newStudentObject.Name = '';
        newStudentObject.Aadhar_Number__c = 0;
        newStudentObject.Mother_Aadhar_Number__c = 0;
        newStudentObject.Father_Aadhar_Number__c = 0;
        newStudentObject.Discount_Requested__c = 0;
    }

    private void initVariables() {
        bothParentsAdharNumbersWrong = false;
        oneParentAdharNumberWrong = false;
        motherInformationMissing = false;
		fatherInformationMissing = false;
        discountNotValid = false;
        newStudentObject = new Student__c();
      
    }

    public PageReference saveRecord() {
       try {
            Boolean isDataValid = isDataValidForDiscount();
            System.debug('Parent Adhaar Error value'+bothParentsAdharNumbersWrong);
            if(isDataValid) {
                insert newStudentObject;
            }
            else {
                if(bothParentsAdharNumbersWrong) {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,  'Adhaar Info of Parents not matching @'+newStudentObject.Name));  
           
                }if(oneParentAdharNumberWrong) {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,  'Adhaar Info of One of the parent is not matching @'+newStudentObject.Name));  
           
                }
                if(motherInformationMissing) {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'MotherAadhar Information missing '+newStudentObject.Name));  
                } 
                if(fatherInformationMissing) {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'FatherAadhar Information missing '+newStudentObject.Name));  
                }
                if(discountNotValid){
                      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Required Discount doesnt meet the criteria for '+newStudentObject.Name));
                }
                else{
                      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'some error occured '+newStudentObject.Name));
                }
            }
            
        }catch(Exception e) {
           System.debug('The Exception is at Stack Trace'+e.getStackTraceString());
           System.debug('The Exception is at Line Number'+e.getLineNumber());
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, e.getMessage(), 'Error Saving the Record @Jasir...please check'));  
        }
        
        return NULL; //..this should return to the list page ... @Jasir to action 
    }
    PageReference returnPage = new PageReference(ApexPages.currentPage().getParameters().get('retURL'));  

    private Boolean isDataValidForDiscount() {
        motherAdhaarNumber = newStudentObject.Mother_Aadhar_Number__c;
        fatherAdhaarNumber = newStudentObject.Father_Aadhar_Number__c;

        System.debug('motherAdhaarNumber --> '+motherAdhaarNumber);
        System.debug('fatherAdhaarNumber --> '+fatherAdhaarNumber);
       

        List<Parent__c> parentRecords = [select Id , 
                                                AAdhar_Number__c, 
                                                name, 
                                                Age__c, 
                                                ParentShip__c, 
                                                Salary__c,
                                                Job_sector__c
                                        from Parent__c 
                                        where AAdhar_Number__c 
                                        IN (:motherAdhaarNumber, :fatherAdhaarNumber)];
        
        System.debug('Parent Records  --> '+parentRecords);
        if(parentRecords.size() == 0) {
            bothParentsAdharNumbersWrong = true;
            return false;
        }
        if(parentRecords.size() == 1) {
            oneParentAdharNumberWrong = true;
            return false;
        }
        for(Parent__c parent : parentRecords) {
            if(parent.ParentShip__c.equalsIgnoreCase('Father')) {
                this.fatherRecord = parent;
            }
            if(parent.ParentShip__c.equalsIgnoreCase('Mother')) {
                this.motherRecord = parent;
            }
        }
        System.debug('this.fatherRecord --> '+this.fatherRecord);
        System.debug('this.motherRecord --> '+this.motherRecord);
        
        if(fatherRecord==Null){
            fatherInformationMissing = true;
            return false;
        }
        
         
        if(motherRecord==Null){
            motherInformationMissing = true;
            return false;
        }
        
        this.fatherOccupation = fatherRecord.Job_sector__c;
        this.motherOccupation = motherRecord.Job_sector__c;
        //Condition 1 - If Father Job is Govt, Mother Job is Govt what is maximum Discount = 5%
        
        System.debug('this.fatherOccupation --> '+this.fatherOccupation);
        System.debug('this.motherOccupation --> '+this.motherOccupation);
        System.debug('this.newStudentObject --> '+this.newStudentObject);
        System.debug('this.newStudentObject.Discount_Requested__c --> '+this.newStudentObject.Discount_Requested__c);
        
        if(this.fatherOccupation.equalsIgnoreCase('Government') && 
          this.motherOccupation.equalsIgnoreCase('Government') &&
          this.newStudentObject.Discount_Requested__c > 5)  {
              discountNotValid =true;
              return false;
          }
        else if(this.fatherOccupation.equalsIgnoreCase('Private') &&
          this.motherOccupation.equalsIgnoreCase('Private') &&
          this.newStudentObject.Discount_Requested__c > 30)  {
              discountNotValid =true;
              return false;
          }
         else if(this.fatherOccupation.equalsIgnoreCase('UnEmployed') &&
          this.motherOccupation.equalsIgnoreCase('UnEmployed') &&
          this.newStudentObject.Discount_Requested__c > 80)  {
              discountNotValid =true;
              return false;
          }
         else if (this.fatherOccupation.equalsIgnoreCase('Government') &&
          this.motherOccupation.equalsIgnoreCase('Private') &&
          this.newStudentObject.Discount_Requested__c > 10)  {
              discountNotValid =true;
              return false;
          }
         else if (this.fatherOccupation.equalsIgnoreCase('Government') &&
          this.motherOccupation.equalsIgnoreCase('UnEmployed') &&
          this.newStudentObject.Discount_Requested__c > 10)  {
              discountNotValid =true;
              return false;
          }
         else if (this.fatherOccupation.equalsIgnoreCase('Private') &&
          this.motherOccupation.equalsIgnoreCase('UnEmployed') &&
          this.newStudentObject.Discount_Requested__c >0 )  {
              discountNotValid =true;
              return false;
          }
         else if (this.fatherOccupation.equalsIgnoreCase('Private') &&
          this.motherOccupation.equalsIgnoreCase('Government') &&
          this.newStudentObject.Discount_Requested__c > 10)  {
             discountNotValid =true;
              return false;
          }
        else if (this.fatherOccupation.equalsIgnoreCase('UnEmployed') &&
          this.motherOccupation.equalsIgnoreCase('Government') &&
          this.newStudentObject.Discount_Requested__c > 10)  {
              discountNotValid =true;
              return false;
          }
         else if (this.fatherOccupation.equalsIgnoreCase('UnEmployed') &&
          this.motherOccupation.equalsIgnoreCase('Private') &&
          this.newStudentObject.Discount_Requested__c > 0)  {
              discountNotValid =true;
              return false;
          }
       
        return false;
        
    }
}