@isTest
public class TestContactTrigger {
    
    @isTest
    public Static void CreateContactTest()
    {	
        User newUser = new User(FirstName = 'UUFN', LastName = 'UULN' , Email = 'newnigashis@gmail.com');
        newUser.LastName = 'Test Code34';
        newUser.Alias = 'Tcode45';
        newUser.Username = 'newnigashis90@test.com';
        newUser.CommunityNickname = 'test12';
        newUser.LocaleSidKey = 'en_US';
        newUser.TimeZoneSidKey = 'GMT';
        newUser.ProfileID = '00eN0000000bLJp';
        newUser.LanguageLocaleKey = 'en_US';
        newUser.EmailEncodingKey = 'UTF-8';
        Insert newUser;
        Contact newContact = new Contact(FirstName = 'CCFN', LastName = 'CCLN' , Email = 'newnigashis@gmail.com');
        test.startTest();
        Database.UpsertResult result = Database.Upsert(newContact);
        test.stopTest();
        User UFName = [Select FirstName from User where Id = :newUser.id];
        //Contact CFName = [Select FirstName from Contact where Id = :newContact.id];
        
        System.assertEquals(true, (UFName.FirstName==newContact.FirstName)) ;
        //System.assertEquals(true, true) ;
        
    }
	@isTest
    public Static void UpdateContactTest()
    {	
        Contact newContact = new Contact(FirstName = 'CFN', LastName = 'CLN' , Email = 'newnigashis@gmail.com');
        insert newContact;
        User newUser = new User(FirstName = 'UFN', LastName = 'ULN' , Email = 'newnigashis@gmail.com');
        newUser.LastName = 'Test Code';
        newUser.Alias = 'Tcode';
        newUser.Username = 'newnigashis@test.com';
        newUser.CommunityNickname = 'test12';
        newUser.LocaleSidKey = 'en_US';
        newUser.TimeZoneSidKey = 'GMT';
        newUser.ProfileID = '00eN0000000bLJp';
        newUser.LanguageLocaleKey = 'en_US';
        newUser.EmailEncodingKey = 'UTF-8';
        insert newUser;
        
        Contact updateContactName = [Select FirstName , LastName from Contact Where Id = :newContact.Id];
        updateContactName.FirstName = 'UpdatedFirstName';
        updateContactName.LastName = 'UpdatedLastName';
        test.startTest();
        Database.UpsertResult result = Database.Upsert(updateContactName);
        test.stopTest();
        User UFName = [Select FirstName from User where Id = :newUser.id];
        
        System.assertEquals(true, (updateContactName.FirstName==UFName.FirstName)) ;
        
    }
    @isTest
    public Static void CreateVendorContactTest()
    {	
        
        Contact newContact = new Contact(FirstName = 'VCFN', LastName = 'VCLN' , Email = 'newnigashis@gmail.com', RecordTypeId = '012N0000002LcVJ');
        test.startTest();
        Database.UpsertResult result = Database.Upsert(newContact);
        test.stopTest();
        Task createdTask = [Select WhoId from task where WhoId = :newContact.id];
        //System.debug(' count of task ' + createdTask.size());
        System.assertEquals(newContact.id, createdTask.WhoId) ;
      
    }
}