public class MultiplePaymentFailOnAccount implements Database.Batchable<sObject> , Database.Stateful {
    
public Integer failedPayments = 0;
    
public Database.QueryLocator start(Database.BatchableContext context) 
{
	String query ='Select  Id , Multiple_Payments_Failed__c, NumberOfFailedPayments__c, Name from Account where  NumberOfFailedPayments__c > 2';
	return Database.getQueryLocator(query); 
}
   public void execute(Database.BatchableContext context, List<Account> accounts) 
{
   
        System.debug('am in execute ' + accounts.size());
        //List<Account> AccountToBeUpdated = new List<Account>();
        Account acc = new Account();
        
    	system.debug(' aman ' + accounts.size());
    	if(accounts.size() > 0)
        {
            for(Account payFailCount : accounts)
            {
                //acc.id = payFailCount.id ;
                //System.debug(' payFailCount.id ' +  payFailCount.id);
                //System.debug('aman here again ' + payFailCount.id + ' ' + payFailCount.NumberOfFailedPayments__c + ' ' + payFailCount.Name);
                acc.Multiple_Payments_Failed__c = true;
                //AccountToBeUpdated.add(acc);
                failedPayments += integer.valueOf(payFailCount.NumberOfFailedPayments__c) ;
            }
        }
        Database.SaveResult[] saveUpdateResult = Database.update(accounts); 
        for (Database.SaveResult sr : saveUpdateResult) {
            if (sr.isSuccess()) {
                System.debug('Successfully updated account. Account ID: ' + sr.getId());
            }
            else {              
                for(Database.Error err : sr.getErrors()) {
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Account fields that affected this error: ' + err.getFields());
                }
            }
            
        }
    
}
    public void finish(Database.BatchableContext context) {  
        AsyncApexJob a = [Select Id, Status,ExtendedStatus,NumberOfErrors,     JobItemsProcessed,
                          TotalJobItems, CreatedBy.Email
                          from AsyncApexJob where Id =:context.getJobId()];
        FailedPaymentInfo__mdt failpmnt = new FailedPaymentInfo__mdt();
        failpmnt.RecipientEmail__c = a.CreatedBy.Email;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {failpmnt.RecipientEmail__c};
            mail.setToAddresses(toAddresses);
        mail.setSubject('Payment status Report ' );
        mail.setPlainTextBody('Today, a total of * ' + failedPayments + '* payments failed ');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    
}