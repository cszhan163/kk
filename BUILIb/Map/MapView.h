//
//  MapViewController.h
//  Miller
//
//  Created by kadir pekel on 2/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "RegexKitLite.h"
#import "Place.h"
#import "PlaceMark.h"

@interface MapView : UIView<MKMapViewDelegate> {

	MKMapView* mapView;
	UIImageView* routeView;
	
	NSArray* routes;
	
//	UIColor* lineColor;

}

//@property (nonatomic, retain) UIColor* lineColor;
@property (nonatomic, retain) MKMapView* mapView;

- (void)clearMapView;

-(void) showRouteFrom: (Place*) f to:(Place*) t;

- (void)showRouteWithPointsData:(NSArray*)points;

-(void) addRouterView:(NSArray*)points;

- (void)addRouterView:(CLLocationCoordinate2D *)points withCount:(int)count;

- (void)addRouterView:(CLLocationCoordinate2D *)points withCount:(int)count withColor:(NSString*)color withCenter:(BOOL)isCenter;

- (void)addFromPoint:(Place*)f toPoint:(Place*)t;
- (void)addPointToMap:(Place*)f;
- (void)centralMapwithPoints:(NSArray*)points;
- (void)centralMapwithPoint:(CLLocationCoordinate2D)point;
- (void)addMotionPointToMap:(Place*)f;
@end
