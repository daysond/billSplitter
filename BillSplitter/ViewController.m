//
//  ViewController.m
//  BillSplitter
//
//  Created by Dayson Dong on 2019-05-12.
//  Copyright © 2019 Dayson Dong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextfield;
@property (weak, nonatomic) IBOutlet UISlider *personSlider;
@property (weak, nonatomic) IBOutlet UILabel *billAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *personNumLabel;
@property (nonatomic) NSDecimalNumber* totalBillAmount;
@property (nonatomic) NSDecimalNumber* billAmount;
@property (nonatomic) NSDecimalNumber* numberOfPerson;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.personSlider.value = 2.0;
    self.numberOfPerson = [NSDecimalNumber decimalNumberWithString:@"2.0"];
    _personNumLabel.text = [NSString stringWithFormat:@"Number Of Person: %@",[[NSNumberFormatter new] stringFromNumber:self.numberOfPerson]] ;
    _billAmountLabel.text = @"";
}
- (IBAction)sliderValueChanged:(UISlider *)sender {
    self.numberOfPerson = [[NSDecimalNumber alloc]initWithInt:(int)sender.value];
     _personNumLabel.text = [NSString stringWithFormat:@"Number Of Person: %@",[[NSNumberFormatter new] stringFromNumber:self.numberOfPerson]] ;
     [self splitBillWithTotal:self.totalBillAmount andNumberOfPerson:self.numberOfPerson];
}
- (IBAction)calculateSplitAmount:(id)sender {
    
    self.totalBillAmount = [NSDecimalNumber decimalNumberWithString:_billAmountTextfield.text];
    [self splitBillWithTotal:self.totalBillAmount andNumberOfPerson:self.numberOfPerson];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];

    if (![text isEqualToString:@""]) {
        self.totalBillAmount = [NSDecimalNumber decimalNumberWithString:text];
        
        [self splitBillWithTotal:self.totalBillAmount andNumberOfPerson:self.numberOfPerson];


    }

    return YES;
    
}

-(void) splitBillWithTotal: (NSDecimalNumber*) total andNumberOfPerson:(NSDecimalNumber*) num {
    NSDecimalNumberHandler *behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:2 raiseOnExactness:NO raiseOnOverflow:YES raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    self.billAmount = [total decimalNumberByDividingBy:num];
    
    _billAmountLabel.text = [NSString stringWithFormat:@"Bill Amount splitted by %@ is $%@ ",num,[self.billAmount decimalNumberByRoundingAccordingToBehavior:behavior]] ;
    
}




@end
