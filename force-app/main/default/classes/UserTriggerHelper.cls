public class UserTriggerHelper {
    
    public Static Void SyncContactWithUser(List<User> userList, boolean isInsert)
    {
        List<String> Email = new List<String>();
        
        for(User usr : userList)
        {
            if(usr.Email != null)
            {	
                if(!Email.contains(usr.Email))
                {
                    Email.add(usr.Email);
                } else {
                    trigger.newmap.get(usr.Id).addError('Users Can\'t have same Email Id');
                }    
            }
        }
        SyncContactNameWithUserName(userList, Email, isInsert);
    }
    public Static Void SyncContactNameWithUserName(List<User> userList , List<String> Email, boolean isInsert)
    {	System.debug(' Aman Inside SyncContactNameWithUserName ');
     List<Contact> Contacts = new List<Contact>();
     Contacts = [select FirstName, LastName, Email from Contact where Email IN :Email];
     
     System.debug(' Aman Contacts.size() ' + Contacts.size());
     for(User usr : userList)
     {
        System.debug(' Aman user Details  ' + usr.Email + ' ' + usr.FirstName); 
         if(Contacts.size()>0)
         { 
             for(Contact ExistingContact : Contacts)
             {
                  System.debug(' Aman Contact Details  ' + ExistingContact.Email + ' ' + ExistingContact.FirstName); 
                 if(usr.Email == ExistingContact.Email)
                 {
                     ExistingContact.FirstName = usr.FirstName;
                     ExistingContact.LastName = usr.LastName;
                 }  
             }
         }else if(isInsert) 
         {   System.debug(' aman add new contact' + usr.FirstName + ' ' + usr.Email + ' ' + usr.LastName );		
             Contacts.add(new Contact(FirstName = usr.FirstName, LastName = usr.LastName, Email = usr.Email, RecordTypeId = '012N0000002LcVE')) ;
         }
     } 
     Database.upsertResult[] upsertContact = Database.Upsert(Contacts,false);  
     
     for(Database.upsertResult updResult : upsertContact)
     {
         if(updResult.isSuccess())
         {
             System.debug(' aman kam tamam');
         }
 		 else
         {
             System.debug(' aman blast ' + updResult .getErrors());
         }
         
     }
    }
    
}