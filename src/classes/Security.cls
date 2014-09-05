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


public with sharing class Security {

    static public boolean Issue() {
        
        //returns true if the current user does not have enough FLS/CRUD
        //TODO:  Return the appropriate message depending on missing FLS or CRUD
        
        boolean toreturn=false;
        
        String [] integrationKeyFields = new String [] {'key__c','secret__c'};                              
        // Obtaining the field name/token map for the Contact object
        Map<String,Schema.SObjectField> m = Schema.SObjectType.Integration_key__c.fields.getMap();
        for (String fieldToCheck : integrationKeyFields) {
        // Check if the user has create access on the each field
            if (!m.get(fieldToCheck).getDescribe().isAccessible()           ) {
                toreturn=true;
            }
        }
        
        String [] deviceFields = new String [] {'type__c','guid__c','authenticated__c','supports_Body_Measures__c','supports_Blood_Measures__c',
           'supports_Activity_Measures__c','supports_Nutrition_Measures__c'
           ,'supports_Breath_Measures__c','Supports_Sleep_Measures__c'};
        
        // Obtaining the field name/token map for the Contact object
        m = Schema.SObjectType.device__c.fields.getMap();
        for (String fieldToCheck : deviceFields) {
        // Check if the user has create access on the each field
            if (!m.get(fieldToCheck).getDescribe().isAccessible() ||
          !m.get(fieldToCheck).getDescribe().isCreateable() ||
           !m.get(fieldToCheck).getDescribe().isUpdateable() 
            ) {
                toreturn=true;
            }
        }
        
        String [] healthFields = new String [] {'X2net_Registered__c','user__c','Heroku_Registered__c','guid__c'};
        
        // Obtaining the field name/token map for the Contact object
        m = Schema.SObjectType.health__c.fields.getMap();
        for (String fieldToCheck : healthFields) {
        // Check if the user has create access on the each field
            if (!m.get(fieldToCheck).getDescribe().isAccessible() ||
            !m.get(fieldToCheck).getDescribe().isCreateable() ||
            !m.get(fieldToCheck).getDescribe().isUpdateable() 
            ) {
                toreturn=true;
            }
        }
        

        
        
               String [] measureFields = new String [] {'health__c','Date_Time__c','Weight__c'};
        
        // Obtaining the field name/token map for the Health__c object
        m = Schema.SObjectType.Measurement__c.fields.getMap();
        for (String fieldToCheck : measureFields) {
        // Check if the user has create access on the each field
            if (!m.get(fieldToCheck).getDescribe().isAccessible()
            ) {
                toreturn=true;
            }
        }
        
        
        return toreturn;
    }


}