//
//  LocationMapView.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationMapView.h"
#import "LocationState.h"
#import "Location.h"
#import "FlexableDictionary.h"

@implementation LocationMapView

@synthesize locationState;

-(id)initWithLocationState:(LocationState *)aLocationState AndFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        locationState = aLocationState;
        annotationViewDict = [[FlexableDictionary alloc] init];
        
        CLLocationCoordinate2D currentLocation = [[aLocationState selectedLocation] coordinate];
        
        MKCoordinateRegion viewRegion = MKCoordinateRegionMake(currentLocation, MKCoordinateSpanMake(0.008f, 0.008f));
        // 3
        MKCoordinateRegion adjustedRegion = [self regionThatFits:viewRegion];                
        // 4
        [self setRegion:adjustedRegion animated:YES];
        
        [self setDelegate:self];
        
        [self performSelectorOnMainThread:@selector(addAnnotations) withObject:nil waitUntilDone:YES];
    }
    
    return self;
}

-(void) addAnnotations
{
    [self addAnnotations:[locationState locations]];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *returnView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"whatever"];
    
    if ([annotation isEqual:[locationState selectedLocation]])
    {
        [returnView setPinColor:MKPinAnnotationColorGreen];
        if (!lastSelectedView) {
            lastSelectedView = returnView;
        }
    }
    else
        [returnView setPinColor:MKPinAnnotationColorRed];
    
    [returnView setCanShowCallout:YES];    
    [returnView setAnimatesDrop:YES];
    
    [annotationViewDict setAssociativeTuple:returnView :annotation];
    
    return returnView;
    
}

-(Location *)annotationForAnnotationView:(MKAnnotationView *)view
{
    return [annotationViewDict objectForKey:view];
}

-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    lastSelectedView = view;
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    [(MKPinAnnotationView *)lastSelectedView setPinColor:MKPinAnnotationColorRed];
    [locationState setSelectedLocation:[self annotationForAnnotationView:view]];
    [(MKPinAnnotationView *)view setPinColor:MKPinAnnotationColorGreen];
}

@end
