//
//  ViewController.m
//  BusRoute
//
//  Created by Marcial Galang on 1/21/14.
//  Copyright (c) 2014 Marc Galang. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "StopDetailViewController.h"
#import "BusPointAnnotation.h"

@interface ViewController () <MKMapViewDelegate>
{
    IBOutlet MKMapView *mapView;
    NSArray *stops;
    CLLocationCoordinate2D coordinate;
    __weak IBOutlet UISegmentedControl *mySegmentedControl;

}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [mySegmentedControl addTarget:self action:@selector(whichView) forControlEvents:UIControlEventValueChanged];
    
    NSURL *url = [NSURL URLWithString:@"http://dev.mobilemakers.co/lib/bus.json"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         stops = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError][@"row"];
         for (NSDictionary *stop in stops) {
             float latitude = [stop[@"latitude"] floatValue];
             float longitude = [stop[@"longitude"] floatValue];
             NSString *stopName = stop[@"cta_stop_name"];
             NSString *routes = stop[@"routes"];
             coordinate = CLLocationCoordinate2DMake(latitude, longitude);
             BusPointAnnotation *annotation = [BusPointAnnotation new];
             annotation.title = stopName;
             annotation.coordinate = coordinate;
             annotation.stop = stop;
             [mapView addAnnotation:annotation];
             
             

         }
     }
     
     ];

}

-(void)viewDidAppear:(BOOL)animated
{
    CLLocationCoordinate2D chicagoCoordinate = CLLocationCoordinate2DMake(41.89373984, -87.63532979);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.5, 0.5);
    MKCoordinateRegion region = MKCoordinateRegionMake(chicagoCoordinate, span);
    [mapView setRegion:region animated:YES];
    
}

-(void)whichView: (UISegmentedControl *)segmentedControl
{
    if ([segmentedControl isEqual:mySegmentedControl])
    {
  //      [
    }
}

-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id<MKAnnotation>)annotation
{
    if(annotation == mapView.userLocation)
    {
        return nil;
    }
    MKAnnotationView *annotationView = [mV dequeueReusableAnnotationViewWithIdentifier:@"Stops"];
    if(annotationView ==nil)
    {
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"Stops"];
        
    }else{
        annotationView.annotation = annotation;
    }
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return annotationView;
    
}
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    StopDetailViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MaxIsTheBest"];
    BusPointAnnotation *temp = view.annotation;
    viewController.stop = temp.stop;

    [self.navigationController pushViewController:viewController animated:YES];
    
}


@end
