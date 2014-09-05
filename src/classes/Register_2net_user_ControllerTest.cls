/* 
Copyright (c) 2014, salesforce.com, Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, 
are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, 
    this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, 
    this list of conditions and the following disclaimer in the documentation 
    and/or other materials provided with the distribution.
    * Neither the name of the salesforce.com, Inc. nor the names of its contributors 
    may be used to endorse or promote products derived from this software 
    without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, 
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED 
OF THE POSSIBILITY OF SUCH DAMAGE.

*/
@isTest (SeeAllData=true)
private class Register_2net_user_ControllerTest {

    //MockTrackDetailsResponseWOArray
    
    static testMethod void listRegisteredDevice() {
               Test.setMock(HttpCalloutMock.class, new MockTrackDetailsResponseWOArray());
               Health__c healthRecord = new Health__c();
               healthRecord.Name='Test';
                      
               
               ApexPages.StandardController standardHealth = new ApexPages.StandardController(healthRecord);
               
               Register_2net_User_Controller controller = new Register_2net_User_Controller(standardHealth);
        	   PageReference nextPage = controller.ListReigsteredDevices();
        	   System.assert(nextPage != null);
        	
    }
    
    
    static testMethod void listRegisteredDevices() {
               Test.setMock(HttpCalloutMock.class, new MockTrackDetailsResponse());
               Health__c healthRecord = new Health__c();
               healthRecord.Name='Test';
                            
               
               ApexPages.StandardController standardHealth = new ApexPages.StandardController(healthRecord);
               
               Register_2net_User_Controller controller = new Register_2net_User_Controller(standardHealth);
        	   PageReference nextPage = controller.ListReigsteredDevices();
        	   System.assert(nextPage != null);
    }
    
    static testMethod void registerwith2net() {
               Test.setMock(HttpCalloutMock.class, new MockRegisterRequestResponse());
               Health__c healthRecord = new Health__c();
               healthRecord.Name='Test';
                            
               
               ApexPages.StandardController standardHealth = new ApexPages.StandardController(healthRecord);
               
               Register_2net_User_Controller controller = new Register_2net_User_Controller(standardHealth);
        	   controller.registerWith2Net();
        	   //System.debug (controller);
        	   System.assert( controller.getisRegistered() ==true);
    }      	   
   
    // MockRegisterRequestResponse
        static testMethod void RegisterWithoAuth() {
               Test.setMock(HttpCalloutMock.class, new MockTrackRegisterResponse());
               Health__c healthRecord = new Health__c();
               healthRecord.Name='Test';
                            
               
               ApexPages.StandardController standardHealth = new ApexPages.StandardController(healthRecord);
               
               Register_2net_User_Controller controller = new Register_2net_User_Controller(standardHealth);
        	   string response=controller.RegisterWithRunKeeper();
        	   //response=controller.RegisterWithRunKeeper();
        	   response=controller.RegisterWithWithings();
        	   response=controller.RegisterWithBodyMedia();
        	   response=controller.RegisterWithfatsecret();
        	   response=controller.RegisterWithFitbit();
        	   response=controller.RegisterWithMapMyFitness();
        	   
        	   System.debug (controller.aHealth[0].id);
        	   System.assert( (controller.aHealth[0].id) != null);
        	   
    }
    
}