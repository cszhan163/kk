//
//  KokTool.m
//  kok
//
//  Created by cszhan on 12-12-11.
//  Copyright (c) 2012年 raiyin. All rights reserved.
//

#import "KokTool.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <SystemConfiguration/SCNetwork.h>
#import <netinet/ip.h>
#import <net/if.h>
#import <sys/sysctl.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <net/ethernet.h>

#include <net/if.h>
#include <net/if_dl.h>
#include <netdb.h> 
#include <arpa/inet.h>

#import <MapKit/MapKit.h>


#define KMobileNetWork      @"中国移动"
#define kUnionNetWork       @"中国联通"
#define kTeleCommNetWork    @"中国电信"
#define kTieTongNetWork     @"中国铁通"
#define LLADDR(s) ((caddr_t)((s)->sdl_data + (s)->sdl_nlen))
@implementation KokTool
+(void)saveByteArray2File:(unsigned char*)pByteArray size:(unsigned int)nSize  directoryName:(NSString*)pDirectoryName fileName:(NSString*)pStrFileName
{
    NSData* pixelData = [[NSData alloc] initWithBytesNoCopy:pByteArray length:nSize freeWhenDone:NO];
    if(pixelData)
    {
        if(pDirectoryName == nil)
            pDirectoryName = [NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];
        
        NSString* pFilePath = [NSString stringWithFormat:@"%@/%@",pDirectoryName,pStrFileName ];
        /*
         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
         NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:pFileName];
         //[[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
         */
        NSError *error = nil;
        if([pixelData writeToFile:pFilePath options:NSDataWritingAtomic error:&error])
        {
            NSLog(@"write ok");
        }
        else
        {
            NSLog(@"write failed:%@",[error description]);
        }
    }
#if __has_feature(objc_arc) != 1
    [pixelData release];
#endif

}
+(void)saveUIImageData:(UIImage*)image directoryName:(NSString*)pDirectoryName fileName:(NSString*)pStrFileName
{
    NSData *pixelData = UIImagePNGRepresentation(image);
    //[UIImage s]]
    // NSData* pixelData = [[NSData alloc] initWithBytesNoCopy:pByteArray length:nSize freeWhenDone:NO];
    if(pixelData)
    {
        if(pDirectoryName == nil)
            pDirectoryName = [NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];
        
        NSString* pFilePath = [NSString stringWithFormat:@"%@/%@",pDirectoryName,pStrFileName ];
        /*
         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
         NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:pFileName];
         //[[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
         */
        NSError *error = nil;
        if([pixelData writeToFile:pFilePath options:NSDataWritingAtomic error:&error])
        {
            NSLog(@"write ok");
        }
        else
        {
            NSLog(@"write failed:%@",[error description]);
        }
    }
}
+(void)deleteNewArrayObject:(char*)ptr
{
#if __has_feature(objc_arc) != 1
    //[pixelData release];
#else
    delete[] ptr;
    ptr = NULL;

#endif
   

}
+(void)newArrayObject:(id)ptr withSize:(int)size
{
   // ptr = new ptr[size];
}
+(void)revertRGBLineRowDataArr:(unsigned char*)ptr withHeight:(int)height withWidth:(int)width
{
    int i,j;
    unsigned char * plinearr = (unsigned char *)malloc(width*3);
    
    for(i=0;i<height;i++)
    {
        for(j =0;j<width;j++)
        {
            plinearr[(width-1-j)*3] = ptr[i*width*3+j*3];
            plinearr[(width-1-j)*3+1] = ptr[i*width*3+j*3+1];
            plinearr[(width-1-j)*3+2] = ptr[i*width*3+j*3+2];
        }
        memcpy(&ptr[i*width*3],plinearr,width*3);
    }
    free(plinearr);
}
+(NSString*)getLocalizedLanguage{
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSLog(@"%@",language);
    return language;
}
+(BOOL) connectedToNetwork:(SCNetworkReachabilityFlags*)flags
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability,flags);
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return 0;
    }
    CFRelease(defaultRouteReachability);
    BOOL isReachable = *flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = *flags & kSCNetworkFlagsConnectionRequired;
    //BOOL isEDGE = *flags & kSCNetworkReachabilityFlagsIsWWAN;
    return (isReachable && !needsConnection) ? YES : NO;
}
#define ReachableVia3G @"3G"
#define ReachableVia2G @"2G"
+(NSString*)getPhoneConnectNetworkInfo{

    SCNetworkConnectionFlags conFlag = 0;
    NSString *connStr = nil;
    if(![[self class]connectedToNetwork:&conFlag]){
        return @"no connect";
    }
    if(!(conFlag &kSCNetworkReachabilityFlagsIsWWAN)){
        connStr = @"WIFI";
    }
    else{
        NSString *subType = @"未知";
#if 0
        if ((conFlag & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
        {
            if((conFlag & kSCNetworkReachabilityFlagsReachable) == kSCNetworkReachabilityFlagsReachable) {
                if ((conFlag & kSCNetworkReachabilityFlagsTransientConnection) == kSCNetworkReachabilityFlagsTransientConnection) {
                    subType = ReachableVia3G;
                    if((conFlag & kSCNetworkReachabilityFlagsConnectionRequired) == kSCNetworkReachabilityFlagsConnectionRequired) {
                        subType = ReachableVia2G;
                    }
                }
            }
        }
#else
        int i = [[self class] dataNetworkTypeFromStatusBar];
        
        if(i == 2){
            subType = @"3G";
        }
        else if(i ==3){
            subType = @"2G";
        }
#endif
        CTTelephonyNetworkInfo *telePhone = [[CTTelephonyNetworkInfo alloc]init];
        CTCarrier *tCarr = telePhone.subscriberCellularProvider;//[[CTCarrier alloc]init];
        telePhone.subscriberCellularProviderDidUpdateNotifier = ^(CTCarrier *ctCarrier){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"%@",[ctCarrier description]);
            });
        };
        NSLog(@"%@",[tCarr description]);
        /*
              [tCarr carrierName]
         00	China Mobile	China Mobile	Operational	GSM 900 / GSM 1800 / TD-SCDMA 1880 / TD-SCDMA 2010
         460	01	China Unicom	China Unicom	Operational	GSM 900 / GSM 1800 / UMTS 2100	CDMA network sold to China Telecom, WCDMA commercial trial started in May 2009 and in full commercial operation as of October 2009.
         460	02	China Mobile	China Mobile	Operational	GSM 900 / GSM 1800 / TD-SCDMA 1880 / TD-SCDMA 2010
         460	03	China Telecom	China Telecom	Operational	CDMA2000 800 / CDMA2000 2100	EV-DO
         460	05	China Telecom	China Telecom	Operational
         460	06	China Unicom	China Unicom	Operational	GSM 900 / GSM 1800 / UMTS 2100
         460	07	China Mobile	China Mobile	Operational	GSM 900 / GSM 1800 / TD-SCDMA 1880 / TD-SCDMA 2010
         460	20	China Tietong	China Tietong
         
             */
//        NSDictionary *networkDict = [NSDictionary dictionaryWithObjectsAndKeys:
//                                     @"00",KMobileNetWork,
//                                     @"02",KMobileNetWork,
//                                     @"07",KMobileNetWork,
//                                     
//                                     @"06",kUnionNetWork,
//                                     @"01",kUnionNetWork,
//                                     
//                                     @"03",kTeleCommNetWork,
//                                     @"05",kTeleCommNetWork,
//                                     
//                                     @"20",kTieTongNetWork,
//                                     nil];
       
        connStr = [NSString stringWithFormat:@"%@_%@_%@",[tCarr  isoCountryCode],[tCarr carrierName],subType];
    }
    //[tCarr carrierName];
    return connStr;
}
+(NSString *)getLocalMacAddress
{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        //printf("Error: if_nametoindex error/n");
        return nil;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        //printf("Error: sysctl, take 1/n");
        return nil;
    }
    
    if ((buf = (char *)malloc(len)) == NULL) {
        //printf("Could not allocate memory. error!/n");
        return nil;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        //printf("Error: sysctl, take 2");
        return nil;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    //NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return [outstring uppercaseString];
}
void
sockaddr_dl_print(struct sockaddr_dl * dl_p)
{
    int i;
    
    printf("link: len %d index %d family %d type 0x%x nlen %d alen %d"
           " slen %d addr ", dl_p->sdl_len,
           dl_p->sdl_index,  dl_p->sdl_family, dl_p->sdl_type,
           dl_p->sdl_nlen, dl_p->sdl_alen, dl_p->sdl_slen);
    for (i = 0; i < dl_p->sdl_alen; i++)
        printf("%s%x", i ? ":" : "",
               ((unsigned char *)dl_p->sdl_data + dl_p->sdl_nlen)[i]);
    printf("\n");
}

//网络类型：
// network type
typedef enum {
    NETWORK_TYPE_NONE				= 0,
    NETWORK_TYPE_WIFI				= 1,
    NETWORK_TYPE_3G				= 2,
    NETWORK_TYPE_2G				= 3,
}NETWORK_TYPE;

+ (int)dataNetworkTypeFromStatusBar {
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    NSNumber *dataNetworkItemView = nil;
    
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    
    int netType = NETWORK_TYPE_NONE;
    NSNumber * num = [dataNetworkItemView valueForKey:@"dataNetworkType"];
    if (num == nil) {
        
        netType = NETWORK_TYPE_NONE;
        
    }else{
        
        int n = [num intValue];
        if (n == 0) {
            netType = NETWORK_TYPE_NONE;
        }else if (n == 1){
            netType = NETWORK_TYPE_2G;
        }else if (n == 2){
            netType = NETWORK_TYPE_3G;
        }else{
            netType = NETWORK_TYPE_WIFI;
        }
        
    }
    
    return netType;
}


//检查当前网络连接是否正常
-(BOOL)connectedToNetWork
{
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
	
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	SCNetworkReachabilityFlags flags;
	
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	
	if (!didRetrieveFlags) {
		printf("Error. Count not recover network reachability flags\n");
		return NO;
	}
	
	BOOL isReachable = flags & kSCNetworkFlagsReachable;
	BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
	return (isReachable && !needsConnection) ? YES : NO;
}

+(NSString*)getIPbyDomain:(NSString*)domain{
    struct hostent	 *remoteHost = gethostbyname([domain UTF8String]);
    struct in_addr addr;
    char *ip = NULL;
    if(remoteHost){
        addr.s_addr = *(u_long *)remoteHost->h_addr_list[0];
        ip = inet_ntoa(addr);
        if(ip){
             return [NSString stringWithUTF8String:ip];
        }
    }
    return nil;
}
#include <ifaddrs.h>
#include <arpa/inet.h>

+(NSString *)getIPAddress {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}

+ (NSString*)getInternetIPAdress{
  
    NSURLRequest *urlReq = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://iframe.ip138.com/ic.asp"]];
    NSError *error = nil;
    NSHTTPURLResponse *respond = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlReq returningResponse:&respond  error:&error];
    //
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingEUC_CN);
    if(enc == kCFStringEncodingInvalidId){
    
    }
    NSString *str = [[NSString alloc]initWithData:data encoding:enc];
    NSArray *array = [str componentsSeparatedByString:@"center"];
    for(id item in array){
        NSLog(@"%@",[item description]);
    }
#if __has_feature(objc_arc)
#else
    [str release];
#endif
    return  array[0];
}
+(BOOL)isIPAdrressAvailable:(NSString*)ipString withPort:(NSString*)port{
    BOOL bRet = FALSE;
    /*
    NSString *fullStr = [NSString stringWithFormat:@"%@:%@",ipString,port];
    */
    
    

    
#if 0
    const char *hostName = [ipString cStringUsingEncoding:NSASCIIStringEncoding];
    struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
    zeroAddress.sin_port = [port intValue];
    inet_aton(hostName, &zeroAddress.sin_addr);
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	SCNetworkReachabilityFlags flags;
	
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	
	if (!didRetrieveFlags) {
		printf("Error. Count not recover network reachability flags\n");
		return NO;
	}
	
	BOOL bRet = flags & kSCNetworkFlagsReachable;
#else
    struct servent *serveEnt;
     serveEnt =  getservbyport(9999,"tcp");
    printf("%s",serveEnt->s_name);
    char **p = serveEnt->s_aliases;
    int i =0;
    while (p[i]) {
        printf("%s",p[i]);
        i++;
    }
    
#endif
  
    return bRet;
}
#define kGPSMaxScale 1000000
- (void)getPlaceNameByPositionArray:(NSArray*)locationArray{
    
    
    
    
    CLGeocodeCompletionHandler handler = ^(NSArray *place, NSError *error) {
        
        for (CLPlacemark *placemark in place) {
            NSString *cityStr,*cityName;
            cityStr = placemark.thoroughfare;
            
            cityName=placemark.name;
            
            NSLog(@"city %@",cityStr);//获取街道地址
            
            NSLog(@"cityName %@",cityName);//获取城市名
            
            break;
            
        }
        
    };
    for(id item in locationArray){
        CLGeocoder *Geocoder=[[CLGeocoder alloc]init];//CLGeocoder用法参加之前博客
        CLLocationDegrees lat = [[item objectForKey:@"lat"]floatValue]/kGPSMaxScale;
        CLLocationDegrees lng = [[item objectForKey:@"lng"]floatValue]/kGPSMaxScale;
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
        [Geocoder reverseGeocodeLocation:loc completionHandler:handler];
    }
    
}
- (void)getPlaceNameByPositionwithLatitue:(CLLocationDegrees)lat withLongitude:(CLLocationDegrees)lng{

    CLGeocodeCompletionHandler handler = ^(NSArray *place, NSError *error) {
        
        for (CLPlacemark *placemark in place) {
            NSString *cityStr,*cityName;
            cityStr = placemark.thoroughfare;
            
            cityName=placemark.name;
            
            NSLog(@"city %@",cityStr);//获取街道地址
            
            NSLog(@"cityName %@",cityName);//获取城市名
            
            break;
            
        }
        
    };
    CLGeocoder *Geocoder=[[CLGeocoder alloc]init];//CLGeocoder用法参加之前博客
//    CLLocationDegrees lat = [[item objectForKey:@"lat"]floatValue]/kGPSMaxScale;
//    CLLocationDegrees lng = [[item objectForKey:@"lng"]floatValue]/kGPSMaxScale;
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
    [Geocoder reverseGeocodeLocation:loc completionHandler:handler];

}
static NSTimeInterval startTimer,endTimer;
+ (void)startTimeCheckPoint:(NSString*)tag{
    startTimer = [[NSDate date]timeIntervalSince1970];
}
+ (void)endTimeCheckPoint:(NSString*)tag{
    endTimer = [[NSDate date]timeIntervalSince1970];
    NE_LOG(@"%@:time interval:%lf",tag,(endTimer-startTimer)/1000.f);
    startTimer = endTimer;
}
@end
