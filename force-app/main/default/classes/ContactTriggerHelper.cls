public class ContactTriggerHelper {
    
    Public Static Void CreateTaskForVendor(List<Contact> ListContact)
    {
        Map<ID,Schema.RecordTypeInfo> recordType_Map = Contact.sObjectType.getDescribe().getRecordTypeInfosById();
        
        for(Contact con : ListContact)
        {
            if(recordType_Map.get(con.recordTypeID).getName().containsIgnoreCase('VENDOR'))
            {
                CreateTask('Send Welcome Email!',con.OwnerId,con.Id);
            }
        }
    }
    Public Static Void CreateTask(String Subject, Id OwnerId, id WhoId)
    {   System.debug(' Aman creating Task ' + WhoId );
        Task ctask = new Task();
                ctask.OwnerId = OwnerId ;
                ctask.Subject = Subject;
                ctask.WhoId  = WhoId;
                insert ctask;
    }
    @future
    public Static Void SyncUserWithContact(String jsonString)
    {	
        System.debug('Aman in future ');
         List<Contact> newContactList = (List<Contact>)System.JSON.deserialize(jsonString,List<Contact>.class);
        List<String> Email = new List<String>();
     
        for(Contact con : newContactList)
        {
            if(con.Email != null)
            {	
                if(!Email.contains(con.Email))
                {
                    Email.add(con.Email);
                } else {
                    trigger.newmap.get(con.Id).addError('Contacts Can\'t have same Email Id');
                }    
            }
        }
        SyncUserNameWithContactName(newContactList, Email);
    }
    public Static Void SyncUserNameWithContactName(List<Contact> newContactList , List<String> Email)
    {
        List<User> Users = new List<User>();
        Users = [select FirstName, LastName, Email from User where Email IN :Email And isActive = true];
    	System.Debug('aman checking size ' + Users.size());
    if(Users.size()>0)
    {
        for(Contact con : newContactList)
        {
            for(User ExistingUser : Users)
            {
                if(con.Email == ExistingUser.Email)
                {
                    ExistingUser.FirstName = con.FirstName;
                    ExistingUser.LastName = con.LastName;
                }     
            }
        }
        Database.upsertResult[] upsertContact = Database.Upsert(Users,false);  
    }
    }
}