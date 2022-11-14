public interface TriggerHandler {

    void afterInsert(List<SObject> newRecords, Map<ID, SObject> newRecordMap);
}