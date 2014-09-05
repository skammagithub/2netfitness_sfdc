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

public with sharing class WeightGraphController {

//public with sharing class OppsChartController {

    //public OppsChartController (){}

   private final Health__c aHealth;
    
    // The extension constructor initializes the private member
    // variable acct by using the getRecord method from the standard
    // controller.
    public WeightGraphController(ApexPages.StandardController stdController) {
        if(Security.Issue()){
           throw new CRUDFLSException(
                'Insufficient CRUD FLS');
       }
        
        this.aHealth= (Health__c)stdController.getRecord();
    }

	public integer getMinWeight() {
		measurement__c measure=[select weight__c from measurement__c where weight__c>0 and Health__c=:aHealth.id order by weight__c asc limit 1];
		return Math.round(measure.weight__c)-10;
	}

    public List<weightData> getWeightDataWithMonthNames() {
        AggregateResult[] result = [SELECT AVG(weight__c) AvgWeight, COUNT(name) noOfWeighIns,
                                    CALENDAR_MONTH(Date_Time__c) month,
                                    CALENDAR_YEAR(Date_Time__c) year
                                    FROM Measurement__c WHERE Weight__c>0 and weight__c!=null and Health__c=:aHealth.id  GROUP BY CALENDAR_YEAR(Date_Time__c),
                                    CALENDAR_MONTH(Date_Time__c) ORDER BY CALENDAR_YEAR(Date_Time__c),CALENDAR_MONTH(Date_Time__c) ];
        //system.debug(result);
        List<WeightData> weightData = new List<WeightData>();
        for (AggregateResult a : result)
        {
            Datetime d=Datetime.newInstance((Integer)a.get('year'),(Integer)a.get('month'), 1);
            WeightData opp = new WeightData(d.format('MMM YYYY'),
                                                      (Integer)a.get('noOfWeighIns'),
                                                      (Double)a.get('AvgWeight'));     

            weightData.add(opp);
        }
        return weightData;
    }

    public class WeightData
    {
        public String month { get; set; }
        public Integer noOfWeighIns { get; set; }
        public Double AvgWeight { get; set; }

        public WeightData(String mon, Integer noOfWINs, Double weight)
        {
            month = mon;
            noOfWeighIns = noOfWINs;
            AvgWeight = weight;
        }
    }
}

//}