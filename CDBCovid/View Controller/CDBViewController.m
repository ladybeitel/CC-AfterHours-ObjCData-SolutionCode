//
//  CDBViewController.m
//  CDBCovid
//
//  Created by Ciara Beitel on 3/19/20.
//  Copyright © 2020 Ciara Beitel. All rights reserved.
//

#import "CDBViewController.h"
#import "CDBCoronaData.h" // import model
#import "CDBCoronaDataController.h" // import model controller

@interface CDBViewController ()
// Create property for model controller
@property (nonatomic) CDBCoronaDataController *coronaDataController;

// Create outlets
@property (weak, nonatomic) IBOutlet UILabel *confirmedLabel;
@property (weak, nonatomic) IBOutlet UILabel *deathsLabel;
@property (weak, nonatomic) IBOutlet UILabel *recoveredLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

// Create action for search button
- (IBAction)searchButtonTapped:(id)sender;

// Create method getWorldData
- (void)getWorldData;

@end

@implementation CDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // create the space and init the coronaDataController
    self.coronaDataController = [[CDBCoronaDataController alloc] init];
    // call the getWorldData method
    [self getWorldData];
}

- (void)getWorldData {
    // on the imported coronaDataController-call the method getWorldData
    [self.coronaDataController getWorldData:^(CDBCoronaData *coronaData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // set labels with data returned from the method on the coronaDataController
            self.countryNameLabel.text = @"World";
            self.confirmedLabel.text = [NSString stringWithFormat:@"%d", coronaData.confirmed];
            self.deathsLabel.text = [NSString stringWithFormat:@"%d", coronaData.deaths];
            self.recoveredLabel.text = [NSString stringWithFormat:@"%d", coronaData.recovered];
        });
    }];
}

- (IBAction)searchButtonTapped:(id)sender {
    // when a user clicks the search button, dismiss the keyboard
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
    // if text on the searchTextField == "World", then call this class' function getWorldData
    if ([self.searchTextField.text isEqualToString:@"World"]) {
        [self getWorldData];
    } else {
        // otherwise set the country name label to the search term text,
        self.countryNameLabel.text = self.searchTextField.text;
        // call the function getCountryData
        [self.coronaDataController getCountryData:self.searchTextField.text completion:^(CDBCoronaData *coronaData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // set the labels to the country's data for countryName/confirmed/deaths/recovered
                self.countryNameLabel.text = self.searchTextField.text;
                self.confirmedLabel.text = [NSString stringWithFormat:@"%d", coronaData.confirmed];
                self.deathsLabel.text = [NSString stringWithFormat:@"%d", coronaData.deaths];
                self.recoveredLabel.text = [NSString stringWithFormat:@"%d", coronaData.recovered];
            });
        }];
    }
}
@end
