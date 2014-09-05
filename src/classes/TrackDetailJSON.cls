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

public with sharing class TrackDetailJSON {

	public class Status {
		public String code;
		public String message;
	}

	public class TrackDetailsResponse {
		public Status status;
		public String guid;
		public TrackDetails trackDetails;
	}

	public TrackDetailsResponse trackDetailsResponse;

	public class TrackDetail {
		public String guid;
		public String Xtype;
		public String authenticated;
		public String supportsBodyMeasures;
		public String supportsBloodMeasures;
		public String supportsActivity;
		public String supportsNutrition;
		public String supportsBreath;
		public String supportsSleep;
	}

	public class TrackDetails {
		public TrackDetail trackDetail;
	}

	
	//public static TrackDetailJSON parse(String json) {
	//	return (TrackDetailJSON) System.JSON.deserialize(json, TrackDetailJSON.class);
	//}
	
	public static TrackDetailJSON parse(String json) {
		json=json.replace('"type"','"Xtype"');
		return (TrackDetailJSON) System.JSON.deserialize(json, TrackDetailJSON.class);
	}
	
	

}