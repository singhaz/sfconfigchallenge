public class QueueableAccountOrder implements Queueable{
    
    public static void execute(System.QueueableContext context)
    {
       List<Account> accounts = [Select id from Account];
    }

}