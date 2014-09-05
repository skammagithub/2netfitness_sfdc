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


@istest private with sharing class TrackDetailJSONTest {

	static testMethod void testParse() {
		
		String json = '{\"trackDetailsResponse\":{\"status\":{\"code\":\"1\",\"message\":\"OK\"},\"guid\":\"anid\",\"trackDetails\":{\"trackDetail\":{\"guid\":\"anid2\",\"type\":\"withings\",\"authenticated\":\"true\",\"supportsBodyMeasures\":\"true\",\"supportsBloodMeasures\":\"false\",\"supportsActivity\":\"false\",\"supportsNutrition\":\"false\",\"supportsBreath\":\"false\",\"supportsSleep\":\"false\"}}}}';
		TrackDetailJson obj = TrackDetailJson.parse(json);
		System.assert(obj != null);
		
		// Done for code coverage
		TrackDetailJson.Status var1 = new TrackDetailJson.Status();
		TrackDetailJson.TrackDetailsResponse var2 = new TrackDetailJson.TrackDetailsResponse();
		TrackDetailJson.TrackDetail var3 = new TrackDetailJson.TrackDetail();
		
	}
	
	static testMethod void testParse2() {
		
		String json = '{"trackDetailsResponse":{"status":{"code":"1","message":"OK"},"guid":"an_id2","trackDetails":{"trackDetail":[{"guid":"an_id2","type":"withings","authenticated":"true","supportsBodyMeasures":"true","supportsBloodMeasures":"false","supportsActivity":"false","supportsNutrition":"false","supportsBreath":"false","supportsSleep":"false"}]}}}';
		TrackDetailJSONWithArray obj = TrackDetailJSONWithArray.parse(json);
		System.assert(obj != null);
		
		// Done for code coverage
		TrackDetailJSONWithArray.Status var1 = new TrackDetailJSONWithArray.Status();
		TrackDetailJSONWithArray.TrackDetailsResponse var2 = new TrackDetailJSONWithArray.TrackDetailsResponse();
		TrackDetailJSONWithArray.TrackDetail var3 = new TrackDetailJSONWithArray.TrackDetail();
		
	
	}
	
}