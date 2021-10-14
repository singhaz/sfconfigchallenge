public class SampleBatchable implements Database.Batchable<sObject> , Database.Stateful {
    
public Integer failedRecords = 0;
    
public Database.QueryLocator start(Database.BatchableContext context) 
{
	String query ='Select Id from Account';
	return Database.getQueryLocator(query); 
}

public void execute(Database.BatchableContext context, List<Account> accounts) 
{	
    Set<String> AccountIds = new Set<String>();
	for(Account account : accounts)
    {
        AccountIds.add(account.Id);
    }
 	List<Invoice__c> Invoices = [Select Id, Invoice_Date__c from Invoice__c where Employer__c in :AccountIds];
 
 	if(Invoices.size()>0)
    {
      for(Invoice__c AccInvoice : Invoices)
      {
          AccInvoice.Invoice_Date__c = Date.newInstance(2021, 10, 06);
      }
    }
     
	Database.UpsertResult[] results = Database.Upsert(Invoices, false);

	for(Database.UpsertResult result : results){
		if(!result.isSuccess()){
		for(Database.Error error: result.getErrors()){
		failedRecords++;
			}
		}
	}
}
public void finish(Database.BatchableContext context) {
    AsyncApexJob a = [Select Id, Status,ExtendedStatus,NumberOfErrors,     JobItemsProcessed,
        TotalJobItems, CreatedBy.Email
        from AsyncApexJob where Id =:context.getJobId()];
          
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {a.CreatedBy.Email};
            mail.setToAddresses(toAddresses);
            mail.setSubject('Match Merge Batch ' + a.Status);
            mail.setPlainTextBody('records processed ' + a.TotalJobItems +
           'with '+ a.NumberOfErrors + ' failures.');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    
	}
}