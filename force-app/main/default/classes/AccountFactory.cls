public class AccountFactory {
    
    public static List<Account> CreateAccounts(Integer NumberOfAccount, String AccountName)
    {
        List<Account> accounts = new List<Account>();
        
        for (integer i=0; i<NumberOfAccount; i++)
        {
            Account account = new Account();
            account.Name = AccountName + i;
            accounts.add(account);
            
        }
        insert accounts;
        return accounts;
    }
    public static List<Payment__c> CreatePayments(List<Account> accounts, Integer NumberOfPaymentPerAccount)
    {
        List<Payment__c> payList = new List<Payment__c>();
        Set<String> AccountIds = new Set<String>();
        for(Account account : accounts)
        {
            AccountIds.add(account.Id);
        }
        for(String aId : AccountIds)
        {
            for(Integer j=0; j<NumberOfPaymentPerAccount; j++){    
                Payment__c payment = new Payment__c(Payment_Amount__c = 0, Payment_Date__c = Date.today(), Type__c = 'External', Payment_Method__c = 'Cash', Status__c = 'Failure', Failure_Reason__c = 'duplicate Currency', Employer1__c = aId);
                payList.add(payment);
            }
        }
        insert payList;
        return payList;
    }
    public static List<Contact> CreateContacts(Integer NumberOfContactPerAccount, String RecordType) 
    {
        List<Contact> conList = new List<Contact>(); 
        
        for(Integer j=0; j<NumberOfContactPerAccount; j++){    
            Contact con = new Contact(FirstName = 'CFS ', LastName = 'CLN ' +j, RecordTypeId =  RecordType);
            if(j>0)
            {
                con.Email = 'newnigashis'   + j + '@gmail.com';
            }
            else 
            {
                con.Email = 'newnigashis@gmail.com';   
            }
            conList.add(con);
            
        }
        return conList;
    }
    public static List<User> CreateUsers(Integer NumberOfUsers) 
    {
        List<User> userList = new List<User>(); 
        
        for(Integer j=0; j<NumberOfUsers; j++){    
            User usr = new User(FirstName = 'UFS ', LastName = 'ULN ' +j);
            if(j>0)
            {
                usr.Email = 'newnigashis'   + j + '@gmail.com';
            }
            else 
            {
                usr.Email = 'newnigashis@gmail.com';   
            }
            userList.add(usr);
            
        }
        return userList;
    }
    
    
}