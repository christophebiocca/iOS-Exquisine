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
#import "CLPinAnnotationView.h"

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
    // Use custom annotation view for anything but the user's locaiton pin
    
    CLPinAnnotationView *clAnnotationView = (CLPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier: @"CLPin"];
    
    if (!clAnnotationView)
    {
        clAnnotationView = [[CLPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CLPin"];
    }
    else
    {
        clAnnotationView.annotation = annotation;
        clAnnotationView.titleLabel.text = annotation.title;
        clAnnotationView.subtitleLabel.text = annotation.subtitle;
    }
    
    if ([annotation isEqual:[locationState selectedLocation]])
    {
        [clAnnotationView setPinColor:MKPinAnnotationColorGreen];
        if (!lastSelectedView) {
            lastSelectedView = clAnnotationView;
        }
    }
    else
        [clAnnotationView setPinColor:MKPinAnnotationColorRed];
    
    [clAnnotationView setAnimatesDrop:YES];
    
    [annotationViewDict setAssociativeTuple:clAnnotationView :annotation];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(centerMapToAnnotation:) name:@"annotationSelected" object:clAnnotationView];
    
    return clAnnotationView;
    
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

-(void) centerMapToAnnotation:(NSNotification *)note
{
    // Type dispatching annotation object
    CLPinAnnotationView *annotation = (CLPinAnnotationView *)[note object];
    
    // animate the map to the pin's coordinates
    [self setCenterCoordinate:annotation.annotation.coordinate animated: YES];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
