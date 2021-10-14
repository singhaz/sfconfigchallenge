@IsTest
public class TestOrdersAndInvoices {
    
    @testsetup
    public Static void CreateSampleData()
    {
	Account testAcc = new Account(Name = 'testclassAcc');
	insert testAcc;
    
	Order_Detail__c OrdDetail = new Order_Detail__c(Status__c = 'New', Order_Date__c = Date.newInstance(2021, 10, 05), Employer__c = testAcc.id);
    insert OrdDetail;    
    }
    
    @Istest public Static void testassociatedOrders()
    {
        Account account = [Select Id, name from Account where Name = 'testclassAcc'];
        test.startTest();
        OrdersAndInvoices.associatedOrders(account.Id);
        test.stopTest();      
    }
    @Istest public Static void testassociatedInvoices()
    {
        Account account = [Select Id, name from Account where Name = 'testclassAcc'];
        test.startTest();
        OrdersAndInvoices.associatedInvoices(account.Id);
        test.stopTest();      
    }
}