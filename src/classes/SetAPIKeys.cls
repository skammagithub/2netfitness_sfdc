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


@RestResource(urlMapping='/SetAPIKeys/*')

global class SetAPIKeys {

@HttpPost  
global static string setKeys(String TwoNetKey, String TwoNetSecret, String JWTToken, String OrgId) {
    //String TwoNetKey = RestContext.request.params.get('TwoNetKey');
    //String TwoNetSecret = RestContext.request.params.get('TwoNetSecret');
    //String JWTToken = RestContext.request.params.get('JWTToken');
    //String OrgId = RestContext.request.params.get('OrgId');
        
        upsert new Integration__c(Name = 'TwoNetKey',Key__c = TwoNetKey) Name;
        upsert new Integration__c(Name = 'TwoNetSecret',Key__c = TwoNetSecret) Name;
        upsert new Integration__c(Name = 'OrgId',Key__c = OrgId) Name;
        upsert new Integration__c(Name = 'JWTToken',Key__c = JWTToken) Name;
     
        return 'OK';
           
    }

}