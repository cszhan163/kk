//
//  Constant.h
//  iPlat4M
//
//  Created by wang yuqiu on 11-5-3.
//  Copyright 2011 baosteel. All rights reserved.
//

//for status get method
#define	defaultSinceId = 0;
#define	defaultCount = 200;
#define	defaultPage	= 1;

//for status unread
#define withNewStatus = 1;
#define withoutNewStatus = 0;

const static NSStringEncoding encoding = NSUTF8StringEncoding;




#define IPLAT4M_PROJECT_TOKEN  @"platmbs"

#define PARAMETER_COMPRESSDATA  @"parameter_compressdata"
#define PARAMETER_URL @"parameter_url"

#define ACCEPT_ENCODING  @"Accept-Encoding"
#define ENCRYPTION_ENCODING  @"Encryption-Encoding"
#define RETURNBYTES @"Returnbytes"
//http request的超时时间
#define TIMEOUTINTERVAL  60

#define  PROJECT_TOKEN  @"projectName"

#define  SERVICE_TOKEN  @"serviceName"

#define  METHOD_TOKEN  @"methodName"

#define  EIINFO_TOKEN  @"eiinfo"

#define  URL_ADDRESS @"urlAddress"

#define  PARAMETER_USER_ID  @"parameter_userid"

#define  PARAMETER_USER_NAME  @"parameter_username"

#define  PARAMETER_APP_CODE @"parameter_appcode"

#define  PARAMETER_DEVICE_ID  @"parameter_deviceid"

#define  PARAMETER_GLOBAL_DEVICE_ID  @"parameter_globaldeviceid"

#define  PARAMETER_PASSWORD  @"parameter_password"

#define  PARAMETER_DEVICETOKEN_ID @"parameter_devicetokenid"

#define  PARAMETER_CLIENTTYPEID  @"parameter_clienttypeid"

#define  PARAMETER_CLIENTVERSION  @"parameter_clienidtversion"

#define PARAMETER_POSTDATA  @"parameter_postdata"

#define  PARAMETER_ENCRYPTDATA  @"parameter_encryptdata"

#define  PARAMETER_USERTOKENID  @"parameter_usertokenid"

#define  PARAMETER_ENCYPTVECTOR  @"parameter_encyptvector"

#define  PARAMETER_ENCYPTKEY  @"parameter_encyptkey"

#define  DATATYPE  @"datatype"

#define  PARAMETER_UPDATEURLSTRING  @"parameter_updateurlstring"

#define  PARAMETER_LASTVERSION  @"parameter_lastversion"

#define  PARAMETER_METHODRETURNBYTES  @"parameter_methodreturnbytes"

#define PARAMETER_SERVICEURLSTRING @"parameter_serviceurlstring"

#define PARAMETER_PLATFORMBUNDLEID @"parameter_platformbundleid"

#define IPLAT4M_STATUS_FAILED  -1

#define  IPLAT4M_STATUS_SUCCESS  1

#define  IPLAT4M_STATUS_INVALID_USER  -2

#define  IPLAT4M_STATUS_TIMEOUT  -3

#define  IPLAT4M_STATUS_CANCELLED  -4

#define  IPLAT4M_STATUS_INVALID_PASSWORD  -5

#define  IPLAT4M_STATUS_UNAUTHENTIFICATION  -6

#define  IPLAT4M_STATUS_NETWORK_ERROR  -7

#define IPLAT4M_STATUS_DEVICE_LOCKED  -8

#define CLIENT_SYC_TIME 60.0


typedef enum
{
    STATE_INVALID=0,
    STATE_CONNECTED=1,
    STATE_SYNCRONIZING=2,
    STATE_DISCONNECTED=3,
	STATE_CREATED=4,
	STATE_QUERYING=5,
}STATE;









