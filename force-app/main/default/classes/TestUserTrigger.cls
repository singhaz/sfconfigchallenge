@isTest
public class TestUserTrigger {
    
    @isTest
    public Static void CreateUserTest()
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
        
        test.startTest();
        Database.UpsertResult result = Database.Upsert(newUser);
        test.stopTest();
        User UFName = [Select FirstName from User where Id = :newUser.id];
        Contact CFName = [Select FirstName from Contact where Id = :newContact.id];
        System.debug(' CreateUserTest   UFName.FirstName ' + UFName.FirstName + ' CFName.FirstName ' + CFName.FirstName);
        System.assertEquals(true, (UFName.FirstName==CFName.FirstName)) ;
        
    }
    @isTest
    public Static void UpdateUserTest()
    {	System.Debug(' aman check isStartContact 1 ' + avoidRecursion.isStartContact);
        Contact newContact = new Contact(FirstName = 'CFN', LastName = 'CLN' , Email = 'newnigashis@gmail.com');
        insert newContact;
        System.Debug(' aman check isStartContact 2 ' + avoidRecursion.isStartContact);
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
     	System.Debug(' aman check isStartContact 3 ' + avoidRecursion.isStartContact);
        User updateUserName = [Select FirstName , LastName from User Where Id = :newUser.Id];
        updateUserName.FirstName = 'UpdatedFirstName';
        updateUserName.LastName = 'UpdatedLastName';
        test.startTest();
        Database.UpsertResult result = Database.Upsert(updateUserName);
        test.stopTest();
        //User UFName = [Select FirstName from User where Id = :newUser.id];
        Contact CFName = [Select FirstName from Contact where Id = :newContact.id];
        System.debug(' UpdateUserTest   updateUserName.FirstName ' + updateUserName.FirstName + ' CFName.FirstName ' + CFName.FirstName);
        System.assertEquals(true, (updateUserName.FirstName==CFName.FirstName)) ;
        
    }
}