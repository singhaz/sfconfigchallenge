public class OrdersAndInvoices {
    
   public static List<Invoice__c> associatedInvoices (String AccId) {
        
        return  [select id, name from Invoice__c where Employer__c =  :AccId];
    }
    
    public static List<Order_Detail__c> associatedOrders (String AccId) {
       
        return [select id, name from Order_Detail__c where Employer__c =  :AccId];
    }

}