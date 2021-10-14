public class ScheduleFailedPaymentEmail implements Schedulable {
    
    public void execute(System.SchedulableContext context) 
    {
        MultiplePaymentFailOnAccount paymentFailCount = new MultiplePaymentFailOnAccount();
        database.executeBatch(paymentFailCount);
    }
    
}