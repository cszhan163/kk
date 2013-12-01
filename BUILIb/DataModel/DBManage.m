//
//  DBManage.m
//  BUILIb
//
//  Created by cszhan on 13-11-5.
//  Copyright (c) 2013年 yunzhisheng. All rights reserved.
//
#import <MapKit/MapKit.h>
#import "DBManage.h"
//#import "convert.h"
static DBManage *gDb = nil;
@interface DBManage(){
    
}
@property(nonatomic,strong)NSDictionary *locationData;
@end
@implementation DBManage
@synthesize delegate;
+(id)getSingletone{
	@synchronized(self)
    {
		if(gDb == nil){
			gDb = [[self alloc]init];
		}
	}
	return gDb;
}
- (void)saveDataToFile:(NSString*)fileName{
    //fileName = @"locationData.plist";
    NSString *path = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),fileName];
    [self.locationData writeToFile:path atomically:YES];
}
- (NSString*)getDataFileFullPath:(NSString*)fileName{
    //fileName = @"locationData.plist";
    NSString *path = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),fileName];
    return path;
}
-(NSDictionary*)getLocationPointsData{
    NSDictionary *locationData = [NSDictionary dictionaryWithContentsOfFile:[self getDataFileFullPath:@"locationData.plist"]];
    if(locationData == nil){
        locationData = [NSDictionary dictionary];
        [self saveDataToFile:@"locationData.plist"];
    }
    self.locationData = locationData;
    return locationData;
}
- (NSString*)getLocationPointNameByLatitude:(double)lat withLogtitude:(double)lng{
    
    NSString *key = [NSString stringWithFormat:@"%0.6lf_%0.6lf",lat,lng];
    NSLog(@"key:%@",key);
    NSString *result = [self.locationData objectForKey:key];
    if(result)
        return result;
    [self getLocationPointsData];
    result = [self.locationData objectForKey:key];
    if(result == nil){
        [self getLocationDataFromVendorWithLatitude:lat withLotitude:lng];
        return nil;
    }
    return result;
}
- (NSString*)getLocationPointNameByLatitude:(double)lat withLogtitude:(double)lng withIndex:(NSInteger)index withTag:(BOOL)tag{
    [self getLocationPointsData];
    NSString *key = [NSString stringWithFormat:@"%0.6lf_%0.6lf",lat,lng];
    NSLog(@"key:%@",key);
    if([self.locationData objectForKey:key] == nil){
        [self getLocationDataFromVendorWithLatitude:lat withLotitude:lng withIndex:index withTag:tag];
        return @"";
    }
    return [self.locationData objectForKey:key];
}
- (void)setLocationPointNameByLatitude:(double)lat withLogtitude:(double)lng withData:(NSString*)name{
    @synchronized(self){
        NSString *key = [NSString stringWithFormat:@"%0.6lf_%0.6lf",lat,lng];
        NSDictionary *srcDict = [self getLocationPointsData];
        NSMutableDictionary *dictData = [NSMutableDictionary dictionaryWithDictionary:srcDict];
        NSLog(@"key:%@,value:%@",key,name);
        if([dictData objectForKey:key]== nil)
            [dictData setValue:name forKey:key];
        self.locationData = dictData;
        [self saveDataToFile:@"locationData.plist"];
    }
}
- (void)setLocationPointNameByLatitude:(double)lat withLogtitude:(double)lng withData:(NSString*)name withIndex:(NSInteger)index withTag:(BOOL)tag{
    @synchronized(self){
        NSString *key = [NSString stringWithFormat:@"%0.6lf_%0.6lf",lat,lng];
        NSDictionary *srcDict = [self getLocationPointsData];
        NSMutableDictionary *dictData = [NSMutableDictionary dictionaryWithDictionary:srcDict];
        NSLog(@"key:%@,value:%@",key,name);
        if([dictData objectForKey:key]== nil)
            [dictData setValue:name forKey:key];
        self.locationData = dictData;
        [self saveDataToFile:@"locationData.plist"];
    }
    
    if(delegate && [delegate respondsToSelector:@selector(didGetLocationData:withIndex:withTag:)]){
        [delegate didGetLocationData:name withIndex:index withTag:tag];
    }
    
}
- (void)setLocationPointNameByLocationSet:(NSArray*)data{
    @synchronized(self){
        NSDictionary *srcDict = [self getLocationPointsData];
        NSMutableDictionary *dictData = [NSMutableDictionary dictionaryWithDictionary:srcDict];
        for (CLPlacemark *placemark in data) {
            NSString *cityStr,*cityName;
            cityStr = placemark.thoroughfare;
            cityName=placemark.name;
            NSLog(@"city %@",cityStr);//获取街道地址
            NSLog(@"cityName %@",cityName);//获取城市名
            double lat =  placemark.location.coordinate.latitude;
            double lng =  placemark.location.coordinate.longitude;
            NSString *key = [NSString stringWithFormat:@"%0.6lf_%0.6lf",lat,lng];
            NSLog(@"key:%@,value:%@",key,cityName);
            [dictData setValue:key forKey:cityName];
            break;
            
        }
        [dictData writeToFile:@"locationData.plist" atomically:YES];
    }
   //self.locationData = dictData;
}

- (void)getLocationDataFromVendorWithLatitude:(double)lat withLotitude:(double)lng{
    
    
    CLGeocodeCompletionHandler handler = ^(NSArray *places, NSError *error) {
        CLPlacemark *placemark  = [places objectAtIndex:0];
        NSString *locationName = placemark.name;
        if([locationName isEqualToString:@""]){
            locationName = placemark.subLocality;
        }
        if(locationName && ![locationName isEqualToString:@""])
            [self setLocationPointNameByLatitude:lat withLogtitude:lng withData:locationName];
        //[[DBManage getSingletone]setLocationPointNameByLocationSet:places ];
        
    };
    CLGeocoder *Geocoder=[[CLGeocoder alloc]init];//CLGeocoder用法参加之前博客
    //    CLLocationDegrees lat = [[item objectForKey:@"lat"]floatValue]/kGPSMaxScale;
    //    CLLocationDegrees lng = [[item objectForKey:@"lng"]floatValue]/kGPSMaxScale;
    CLLocationCoordinate2D coordinate2d;
    coordinate2d.latitude = lat;
    coordinate2d.longitude = lng;
    coordinate2d = transform(coordinate2d);
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:coordinate2d.latitude longitude:coordinate2d.longitude];
    [Geocoder reverseGeocodeLocation:loc completionHandler:handler];
    SafeRelease(loc);
    SafeRelease(Geocoder);
}
- (void)getLocationDataFromVendorWithLatitude:(double)lat withLotitude:(double)lng withIndex:(NSInteger)index withTag:(BOOL)tag{
    CLGeocodeCompletionHandler handler = ^(NSArray *places, NSError *error) {
        CLPlacemark *placemark  = [places objectAtIndex:0];
        NSString *locationName = placemark.name;
        if([locationName isEqualToString:@""]){
            locationName = placemark.subLocality;
        }
        if(locationName && ![locationName isEqualToString:@""])
            [self setLocationPointNameByLatitude:lat withLogtitude:lng withData:locationName withIndex:index withTag:tag];
        //[[DBManage getSingletone]setLocationPointNameByLocationSet:places ];
        
    };
    CLGeocoder *Geocoder=[[CLGeocoder alloc]init];//CLGeocoder用法参加之前博客
    //    CLLocationDegrees lat = [[item objectForKey:@"lat"]floatValue]/kGPSMaxScale;
    //    CLLocationDegrees lng = [[item objectForKey:@"lng"]floatValue]/kGPSMaxScale;
    CLLocationCoordinate2D coordinate2d;
    coordinate2d.latitude = lat;
    coordinate2d.longitude = lng;
    coordinate2d = transform(coordinate2d);
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:coordinate2d.latitude longitude:coordinate2d.longitude];
    [Geocoder reverseGeocodeLocation:loc completionHandler:handler];
    SafeRelease(loc);
    SafeRelease(Geocoder);

}
- (NSArray*)getMessageHistData:(NSString*)userId{
    NSString *fileName = [NSString stringWithFormat:@"%@.data",userId];
    NSArray *data = [NSArray arrayWithContentsOfFile:[self getDataFileFullPath:fileName]];
    //if([self getDataFileFullPath])
    if(data == nil){
        return  [NSMutableArray array];
    }
    else{
        return data;
    }
}
- (void)saveMessageHistData:(NSArray*)data withUserId:(NSString*)userId{
    NSString *fileName = [NSString stringWithFormat:@"%@.data",userId];
    [data writeToFile:[self getDataFileFullPath:fileName] atomically:YES];
}
@end
