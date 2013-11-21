//
//  WeiXinShareMgr.m
//  kok
//
//  Created by cszhan on 12-12-4.
//  Copyright (c) 2012年 raiyin. All rights reserved.
//

#import "WeiXinShareMgr.h"
#import "WXApi.h"
//#import "ShareDataOperation.h"
//#import "ShareDataModel.h"
//#import "SBJsonWriter.h"
//#import "UIImage+CS_Extensions.h"
static  WeiXinShareMgr *sharedInstance = nil;
@interface WeiXinShareMgr()<WXApiDelegate>
//ShareDataOperationDelegate>
@property(nonatomic,retain)NSString *srcAppName;
@end
@implementation WeiXinShareMgr
@synthesize sendDataDelegate;
@synthesize getDataDelegate;
@synthesize srcAppName;
+(id)getSingleTone{
    @synchronized(self){
    
        if(sharedInstance == nil){
            sharedInstance = [[[self class]alloc]initAndRegister];
        }
        return sharedInstance;
    }
}
-(id)initAndRegister{
    @try {
        if (self = [super init])
        {
            //register weixin open api
           NSDictionary *bundleDict = [[NSBundle mainBundle] infoDictionary];
            //NSLog(@"%@",[bundleDict description]);
            int index = 0;
#ifdef TEST
            //distribution app id
            index = 1;
#endif
#if 0
            NSArray *appIdArray = [[[bundleDict objectForKey:@"CFBundleURLTypes"] objectAtIndex:0] objectForKey:@"CFBundleURLSchemes"];
            for(id item in appIdArray)
            {
                NSLog(@"register appId:%@",item);

                if(![WXApi registerApp:item]){
                    NSLog(@"weixin register appId:%@failed",item);
                    return nil;
                }
            }
            /*
            if(![WXApi registerApp:item]){
                NSLog(@"weixin register appId:%@failed",item);
                return nil;
            }
            */
#else
            if(![WXApi registerApp:kWXAppId]){
                NSLog(@"weixin register appId:%@failed",kWXAppId);
                return nil;
            }
#endif
        }
    }
    @catch (NSException *exception) {
        NSLog(@"weixin init failed");
    }
    @finally
    {
        
    }
    return self;
}
#pragma mark from weixin 
-(BOOL)handleOpenFromWeiXin:(NSURL*)url
{
    BOOL isOk = NO;
    isOk = [WXApi handleOpenURL:url delegate:self];
    if(!isOk){
        
    }
    return isOk;
}
- (BOOL)handleOpenFromWeiXin:(NSURL *)url fromSourceApplication:(NSString*)app withParam:(id)param {
    BOOL isOk = NO;
    isOk = [WXApi handleOpenURL:url delegate:self];
    if(isOk){
         self.srcAppName = app;
    }
    return isOk;
}
#pragma mark return weixin
- (BOOL)returnToWXApp{
    NSString *urlStr = [NSString  stringWithFormat:@"%@://",@"weixin"];
    NSURL *appUrl  = [NSURL URLWithString:urlStr];
    if([[UIApplication sharedApplication]canOpenURL:appUrl]){
        [[UIApplication sharedApplication]openURL:appUrl];
        return YES;
    }
    return NO;
}
#pragma mark handle request from weixin 
-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        [self onRequestAppMessage];
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        [self onShowMediaMessage:temp];
    }
    
}
#pragma mark handle respond from weixin 
-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        
        NSString *strTitle = [NSString stringWithFormat:@"发送结果"];
        NSString *strMsg = [NSString stringWithFormat:@"发送媒体消息结果:%d", resp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
#if __has_feature(objc_arc)
        
#else 
        [alert release];
#endif
    }
    else if([resp isKindOfClass:[SendAuthResp class]])
    {
        NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
        NSString *strMsg = [NSString stringWithFormat:@"Auth结果:%d", resp.errCode];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
#if __has_feature(objc_arc)
        
#else
        [alert release];
#endif
    }
}
-(void)onRequestAppMessage
{
#ifdef TEST
    //[ sendResp:(BaseResp*)resp
    //[self sendAppDataToWeixin:nil];
#endif
    if(sendDataDelegate&& [sendDataDelegate respondsToSelector:@selector(openFromWeiXin:)])
        [self.sendDataDelegate openFromWeiXin:self];
}
#pragma mark public 
-(void)sendTextDataToWeiXin:(NSString*)text
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"麦当劳“销售过期食品”其实不是卫生问题";
    message.description = @"3.15晚会播出当晚，麦当劳该店所在辖区的卫生、工商部门就连夜登门调查，并对腾讯财经等媒体公布初步结果；而尽管未接到闭店处罚通知，麦当劳中国总部还是在发布道歉声明后暂停了该店营业。\
    \
    不得不承认，麦当劳“销售过期食品”固然是事实，但这个“过期”仅仅是他们自己定义的过期，普通中国家庭也不会把刚炸出来30分钟的鸡翅拿去扔掉。麦当劳在食品卫生上的严格程度，不仅远远超出了一般国内企业，而且也超出了一般中国民众的心理预期和生活想象。大多数人以前并不知道，麦当劳厨房的食品架上还有计时器，辣鸡翅等大多数食品存放半个小时之后，按规定就应该扔掉。也正因如此，甚至有网友认为央视3.15晚会的曝光是给麦当劳做的软广告。\
    \
    央视视频中反映的情况，除了掉到地上的的食品未经任何处理继续加工显得很过分外，其它的问题都源于麦当劳自己制定的标准远远超出了国内一般快餐店的标准。比如北京市卫生监督所相关负责人介绍，麦当劳内部要求熟菜在70℃环境下保存2小时，是为了保存食品风味，属于企业内部卫生规范。目前的检查结果显示，麦当劳的保温盒温度在93℃，但在这种环境下保存的熟菜即便超过2小时，对公众也没有危害。也就是说麦当劳的一些保持时间标准是基于保持其食品的独特风味的要求，并非食品发生变质可能损害消费者身体健康的标准，麦当劳这家门店超时存放食品的行为，违反的是企业制定的内部标准，并不违反食品安全规定，政府应该依据法律法规来监管食品卫生，而不是按照食品公司自己制定的标准，从这个角度来看，麦当劳在食品卫生上没有责任（除了使用掉在地上的食物）。…[详细]\
    \
    但三里屯麦当劳的行为确实违背了诚信\
    麦当劳的内部卫生规定虽然并未被作为卖点进行宣扬，但洋快餐在中国是便捷和卫生的代名词，却是不争的事实。谁也不是活雷锋，麦当劳制定的严苛内部标准，为的是树立自己的品牌优势，进而在市场定位上取得明显的价格优势，或者说让自己“贵得有理由”。但如果他的员工在执行上不能贯彻这一企业标准，相对于其价格水平而言，就有欺诈和损害消费者权益之嫌，这也是不言而喻的。从这个意义上来说，央视曝光麦当劳的问题并无不妥，麦当劳至少涉嫌消费欺诈，因为它没有向消费者提供它向人们承诺的标准的食品。也就是说，工商部门而非食品卫生监管部门约谈麦当劳，也并非师出无名。";
    [message setThumbImage:[UIImage imageNamed:@"res2.jpg"]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = @"http://view.news.qq.com/zt2012/mdl/index.htm";
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc]init];
    req.bText = NO;
    req.message = message;
    req.scene =  WXSceneSession;
    [WXApi sendReq:req];
#if __has_feature(objc_arc) == 1
#else
    [req autorelease];
#endif
}
- (void)sendMediaDataToWeiXin:(id)data
{

}
- (BOOL)sendKokImageDataToWeiXin:(UIImage*)data thumbData:(UIImage*)thumbData{
    // 发送内容给微信
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"名片王中王";
    message.description = @"";
   
    NSData *pngImageData = UIImageJPEGRepresentation(data,1.0);
    //assert(imgLen);
    //assert(cardDatalen);
    [message setThumbImage:thumbData];
    
    WXImageObject *imageObj = [WXImageObject object];
    imageObj.imageData = pngImageData;
    message.mediaObject = imageObj;
    return [self sendWXRespondMsg:message];
}
#define BUFFER_SIZE 1024 * 100
- (void)sendAppDataToWeixin:(id)appData{
    // 发送内容给微信
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"这是App消息";
    message.description = @"你看不懂啊，看不懂啊， 看不懂！";
    [message setThumbImage:[UIImage imageNamed:@"res2.jpg"]];
    
    WXAppExtendObject *ext = [WXAppExtendObject object];
    ext.extInfo = @"<xml>test</xml>";
    ext.url = @"http://www.qq.com";
    
    Byte* pBuffer = (Byte *)malloc(BUFFER_SIZE);
    memset(pBuffer, 0, BUFFER_SIZE);
    NSData* data = [NSData dataWithBytes:pBuffer length:BUFFER_SIZE];
    free(pBuffer);
    
    ext.fileData = data;
    
    message.mediaObject = ext;
    [self sendWXRespondMsg:message];
   
}
- (BOOL)sendWXRespondMsg:(WXMediaMessage*)message{
    BOOL sendStatus = YES;
    GetMessageFromWXResp* req = [[GetMessageFromWXResp alloc] init];
    req.bText = NO;
    req.message = message;
    // req.scene = WXSceneSession;
    
    if(![WXApi sendResp:req]){
        NSLog(@"send respond failed");
        //return NO;
        sendStatus = NO;
    }
#if __has_feature(objc_arc)
    
#else
    [req  release];
#endif
    if(sendDataDelegate&& [sendDataDelegate respondsToSelector:@selector(openFromWeiXin:)])
        [self.sendDataDelegate sendData:self withStatus:sendStatus];
    return  sendStatus;
}


#pragma mark parser delegate
/*
 cardJsonData,@"cardData",NSArray or NSDict
 cardImage,@"cardImage",
 */
@end
