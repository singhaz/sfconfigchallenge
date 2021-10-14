@isTest
public class ScheduleFailedPaymentEmailTest {

    @TestSetup
    public Static Void setDataforTest()
    {
        List<Account> testAccounts = AccountFactory.CreateAccounts(3,'Acc_');
        List<PAyment__c> testPayment = AccountFactory.CreatePayments(testAccounts, 4);
    }
    
    @isTest
    Public Static Void InvokeSchedulableClassTest()
    {
        
		Test.StartTest();
		ScheduleFailedPaymentEmail schedulableBatch = new ScheduleFailedPaymentEmail();
		String sch =  '0 30 1 10 * ?';
		String jobId = system.schedule('Test Schedulable', sch, schedulableBatch);
		Test.stopTest();
	}
    
}