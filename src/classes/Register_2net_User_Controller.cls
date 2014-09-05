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

public with sharing class Register_2net_User_Controller {
 
// private final Health__c health;
 private final Id userID=UserInfo.getUserId();
 private Id healthId;
 private boolean registered=false; //registered with 2net
 private boolean registeredheroku=false; //registered with heroku
 public list<health__c> aHealth;  //used to find and create the health record that corresponds to the user id
 
    public Register_2net_User_Controller(ApexPages.StandardController stdController) {
       
       if(Security.Issue()){
           throw new CRUDFLSException(
                'Insufficient CRUD FLS');
       }
            aHealth = [SELECT X2net_Registered__c, guid__c, Heroku_Registered__c FROM Health__c WHERE User__c = :userId Limit 1];
            if ((aHealth.size()==1) ) {
                registered=aHealth[0].X2net_Registered__c;
                registeredheroku=aHealth[0].Heroku_Registered__c;
                healthId=aHealth[0].id;
                //system.debug('health id'+healthId);
            }
            if (aHealth.size()==0) {
                //system.debug('aHeath size was 0');
                 registered=false;
                registeredheroku=false;
                aHealth.add(new Health__c(Name=userInfo.getFirstName()+' '+userInfo.getLastName(),user__c=userId,guid__c=userId,X2net_Registered__c=false,Heroku_Registered__c=false));
            }
       
    }


     
    public PageReference ListReigsteredDevices() {
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndPoint( qualcomm2net.endpoint+'partner/user/tracks/details/'+userId);
        req.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(Blob.valueof(Qualcomm2net.key+':'+Qualcomm2net.secret)));
        req.setHeader('Accept-Encoding','gzip');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Accept','application/json');
        req.setCompressed(true);
        Http http = new Http();
        HTTPResponse res = http.send(req);
        //System.debug(res.getBody());
        
       
        
        list<Device__c> Devices = new list<Device__c>();
        if (res.getBody().contains(':[{')) {
        	
        TrackDetailJSONWithArray aTrackDetailJSON=new TrackDetailJSONWithArray();
        aTrackDetailJSON=TrackDetailJSONWithArray.parse(res.getBody());
        
               
        
                
                
                
        for(TrackDetailJSONWithArray.trackdetail aDetail : aTrackDetailJSON.TrackDetailsResponse.trackdetails.trackdetail) {
            Device__c aDevice = new Device__c();
            aDevice.type__c=aDetail.Xtype;
            aDevice.guid__c=aDetail.guid;
            aDevice.health__c=healthID;
            aDevice.authenticated__c=false;
            aDevice.supports_Body_Measures__c=false;
            aDevice.supports_Blood_Measures__c=false;
            aDevice.supports_Activity_Measures__c=false;
            aDevice.supports_Nutrition_Measures__c=false;
            aDevice.supports_Breath_Measures__c=false;
            aDevice.Supports_Sleep_Measures__c=false;
            if (aDetail.authenticated=='true') {
                aDevice.authenticated__c=true;
            }
            if (aDetail.supportsBodyMeasures=='true') {
                aDevice.supports_Body_Measures__c=true;
            }
            if (aDetail.supportsBloodMeasures=='true') {
                aDevice.supports_Blood_Measures__c=true;
            }
            if (aDetail.supportsActivity=='true') {
                aDevice.supports_Activity_Measures__c=true;
            }
            if (aDetail.supportsNutrition=='true') {
                aDevice.supports_Nutrition_Measures__c=true;
            }
            if (aDetail.supportsBreath=='true') {
                aDevice.supports_Breath_Measures__c=true;
            }
            if (aDetail.supportsSleep=='true') {
                aDevice.Supports_Sleep_Measures__c=true;
            }
         
            aDevice.health__c=healthID;
            devices.add(adevice);
       
     
          }
        } // end if cotains array
        else  {
        	
        	TrackDetailJSON aTrackDetailJSON=new TrackDetailJSON();
        aTrackDetailJSON=TrackDetailJSON.parse(res.getBody());
        
              
        
                
                
                
        //for(TrackDetailJSONWithArray.trackdetail aDetail : aTrackDetailJSON.TrackDetailsResponse.trackdetails.trackdetail) {
            Device__c aDevice = new Device__c();
            aDevice.type__c=aTrackDetailJson.trackDetailsResponse.Trackdetails.trackdetail.Xtype;
            aDevice.guid__c=aTrackDetailJson.trackDetailsResponse.Trackdetails.trackdetail.guid;
            aDevice.health__c=healthID;
            aDevice.authenticated__c=false;
            aDevice.supports_Body_Measures__c=false;
            aDevice.supports_Blood_Measures__c=false;
            aDevice.supports_Activity_Measures__c=false;
            aDevice.supports_Nutrition_Measures__c=false;
            aDevice.supports_Breath_Measures__c=false;
            aDevice.Supports_Sleep_Measures__c=false;
            if (aTrackDetailJson.trackDetailsResponse.Trackdetails.trackdetail.authenticated=='true') {
                aDevice.authenticated__c=true;
            }
            if (aTrackDetailJson.trackDetailsResponse.Trackdetails.trackdetail.supportsBodyMeasures=='true') {
                aDevice.supports_Body_Measures__c=true;
            }
            if (aTrackDetailJson.trackDetailsResponse.Trackdetails.trackdetail.supportsBloodMeasures=='true') {
                aDevice.supports_Blood_Measures__c=true;
            }
            if (aTrackDetailJson.trackDetailsResponse.Trackdetails.trackdetail.supportsActivity=='true') {
                aDevice.supports_Activity_Measures__c=true;
            }
            if (aTrackDetailJson.trackDetailsResponse.Trackdetails.trackdetail.supportsNutrition=='true') {
                aDevice.supports_Nutrition_Measures__c=true;
            }
            if (aTrackDetailJson.trackDetailsResponse.Trackdetails.trackdetail.supportsBreath=='true') {
                aDevice.supports_Breath_Measures__c=true;
            }
            if (aTrackDetailJson.trackDetailsResponse.Trackdetails.trackdetail.supportsSleep=='true') {
                aDevice.Supports_Sleep_Measures__c=true;
            }
         
            aDevice.health__c=healthID;
            devices.add(adevice);
       
        	
        //}
        }
        
        upsert devices GUID__c;
        Schema.DescribeSObjectResult r = Device__c.sObjectType.getDescribe();
        String prefix = r.getKeyPrefix();
        ApexPages.PageReference p = new PageReference('/' + prefix + '/o');
        return p;
    }
    
  
    
    public String RegisterWithRunKeeper() {
        return RegisterWithoAuth('runkeeper');
    }
    
    public String RegisterWithWithings() {
        return RegisterWithoAuth('withings');
    }
    
    public String RegisterWithBodyMedia() {
        return RegisterWithoAuth('bodymedia');
    }
    
     public String RegisterWithfatsecret() {
        return RegisterWithoAuth('fatsecret');
    }
    
    public String RegisterWithFitbit() {
        return RegisterWithoAuth('fitbit');
    }
    
     public String RegisterWithMapMyFitness() {
        return RegisterWithoAuth('mapmyfitness');
    }
    
    public void RegisterWithHeroku() {
    
        //list<JWTToken__c> jwt = [SELECT token__c, orgid__c FROM JWTToken__c Limit 1];
        //  if ((jwt.size() != 1)) {
        //        //error condition
        //  }
        
        //get the value stored protected custom setting
            Integration__c aValue=Integration__c.getValues('OrgId');
            string orgid=aValue.Key__c;
            aValue=Integration__c.getValues('JWTToken');
            string jwt_token=aValue.Key__c;
          
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndPoint( 'https://dev2netlab.herokuapp.com/Register');
        req.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(Blob.valueof(Qualcomm2net.key+':'+Qualcomm2net.secret)));
        req.setHeader('Accept-Encoding','gzip');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Accept','application/json');
        
        req.setCompressed(false);
      	req.setBody('{"sf_user_id":"'+ahealth[0].guid__c+'", "sf_org_id":"' + orgid + '", "jwt_token":"' + jwt_token + '"}');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        //System.debug(res.getBody());
         if (res.getStatusCode()==200) {
                //system.debug('aHealth:' +aHealth);
                aHealth[0].Heroku_Registered__c=true;
                registeredheroku=true;
                upsert aHealth guid__c;
                //healthId=aHealth[0].id;
                
        }
        
    }
    
    
    public String RegisterWithoAuth(string DeviceName) {
        
        //system.debug('Authroization'+ EncodingUtil.base64Encode(Blob.valueof(Qualcomm2net.key+':'+Qualcomm2net.secret)) );
        
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndPoint( qualcomm2net.endpoint+'partner/user/track/register');
        req.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(Blob.valueof(Qualcomm2net.key+':'+Qualcomm2net.secret)));
        req.setHeader('Accept-Encoding','gzip');
        req.setHeader('Content-Type', 'application/xml');
        req.setHeader('Accept','application/xml');
        req.setCompressed(true);
        req.setBody('<?xml version="1.0" encoding="UTF-8" standalone="yes"?><trackRegistrationRequest><guid>'+userId+'</guid><type>'+DeviceName+'</type><registerType>oauth</registerType></trackRegistrationRequest>');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        //System.debug(res.getBody());
        Dom.Document doc = res.getBodyDocument();
        
        //Retrieve the root element for this document.
        Dom.XMLNode trackRegistrationResponse = doc.getRootElement();
        Dom.XMLNode status=trackRegistrationResponse.getChildElement('status', null);
        //System.debug('status: ');
        String code = status.getChildElement('code', null).getText();
        String message = status.getChildElement('message', null).getText();
        // print out specific elements
        //System.debug('code: ' + code);
        //System.debug('message: ' + message);
        if (code=='1') {
                 Dom.XMLNode oAuth=trackRegistrationResponse.getChildElement('oauthAuthorizationUrl', null);
                 String oAuthURL=oAuth.getText();
                 //System.debug(oAuthURL);
                 return oAuthURL;
        }
        
        return null;        
    }
    
   
    public Boolean getisRegistered() {
        return registered;
    }
    
    public Boolean getIsNotRegistered() {
        return !registered;
    }
    
    public Boolean getIsHerokuRegistered() {
    	return registeredheroku;
    }
    
    public Boolean getIsNotHerokuRegistered() {
    	return !registeredheroku;
    }
    
    public Boolean getIsreadyforDevices() {
    	if (registered && registeredHeroku)
    		return false;
    	else 
    		return true;
    }
    
    public void registerWith2Net() {
    
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndPoint( qualcomm2net.endpoint+'partner/register');
        req.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(Blob.valueof(Qualcomm2net.key+':'+Qualcomm2net.secret)));
        req.setHeader('Accept-Encoding','gzip');
        req.setHeader('Content-Type', 'application/xml');
        req.setHeader('Accept','application/xml');
        req.setCompressed(true);
        req.setBody('<?xml version="1.0" encoding="UTF-8" standalone="yes"?><registerRequest><guid>'+userId+'</guid></registerRequest>');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        //System.debug(res.getBody());
        Dom.Document doc = res.getBodyDocument();
        
        //Retrieve the root element for this document.
        Dom.XMLNode trackGuidResponse = doc.getRootElement();
        Dom.XMLNode status=trackGuidResponse.getChildElement('status', null);
        //System.debug('status: ');
        String code = status.getChildElement('code', null).getText();
        String message = status.getChildElement('message', null).getText();
        // print out specific elements
        //System.debug('code: ' + code);
        //System.debug('message: ' + message);
        if (code=='1') {
                //system.debug('aHealth:' +aHealth);
                aHealth[0].X2net_Registered__c=true;
                registered=true;
                upsert aHealth guid__c;
                //healthId=aHealth[0].id;
                
        }
     
                
       
        
        
    }

        

}