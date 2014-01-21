//
//  StopDetailViewController.m
//  BusRoute
//
//  Created by Marcial Galang on 1/21/14.
//  Copyright (c) 2014 Marc Galang. All rights reserved.
//

#import "StopDetailViewController.h"

@interface StopDetailViewController ()
{
    __weak IBOutlet UILabel *stopAddress;
    __weak IBOutlet UILabel *stopRoutes;
    __weak IBOutlet UILabel *stopTransfers;
}

@end

@implementation StopDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = _stop[@"cta_stop_name"];
    stopRoutes.text = _stop[@"routes"];
    stopTransfers.text = _stop[@"inter_modal"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
