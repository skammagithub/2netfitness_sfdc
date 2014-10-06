@RestResource(urlMapping='/SetKeys/*')

global class SetKeys {

@HttpPost
  global static String doPost(String jwt) {
    String jwtToken = jwt; // RestContext.request.params.get('jwt');

    if (jwtToken == null || jwtToken == '') {
        jwtToken = 'token value did not come through';
    }

    return 'SetKeys, got jwt: ' + jwtToken;
    }
 
 }