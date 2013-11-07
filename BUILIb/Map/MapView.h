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

-(void) showRouteFrom: (Place*) f to:(Place*) t;

- (void)showRouteWithPointsData:(NSArray*)points;

- (void)addFromPoint:(Place*)f toPoint:(Place*)t;
- (void)addPointToMap:(Place*)f;
@end
