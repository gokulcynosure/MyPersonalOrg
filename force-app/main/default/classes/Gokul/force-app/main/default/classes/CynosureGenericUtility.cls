public class CynosureGenericUtility {
    public static CynoParent getRecordWithMoreSalary(CynoParent firstRecord, CynoParent secondRecord) {
        if(firstRecord.yearSalary == NULL || firstRecord.yearSalary== 0) {
           return secondRecord;
        }

        if(secondRecord.yearSalary == NULL || secondRecord.yearSalary ==0){
            return firstRecord;
        }
        if(firstRecord.yearSalary > secondRecord.yearSalary) {
            return firstRecord;
        }
        
        return secondRecord;
    }

   public static CynoAddress getRecordDifferentAddress(CynoAddress firstRecord, CynoAddress secondRecord){
    if(firstRecord.firstLineOfAddress != secondRecord.firstLineOfAddress)
        {
        return firstRecord;
    }
    return secondRecord;
   }  
   
   public static CynoParent getRecordWithBothParentsAreUnemployee(CynoParent firstRecord, CynoParent secondRecord) {
    if(firstRecord.unEmployee == true && secondRecord.unEmployee == true){
       return firstRecord;
       }
       
   return secondRecord;
}
public static CynoParent getRecordWithAnyParentsAreUnemployee(CynoParent firstRecord, CynoParent secondRecord) {
    if(firstRecord.unEmployee == true || secondRecord.unEmployee == true){
       return firstRecord;
       }
       
   return secondRecord;
}
}