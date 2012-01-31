//
//  PaymentView.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentView.h"
#import "PaymentInfo.h"

#define UIToolbarHeight 44
#define TextFieldHeight 30
#define LabelFieldPadding 5
#define InterFieldPadding 15

@implementation PaymentView

@synthesize done, cancel, paymentInfo;

- (id)init
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:nil];
        cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:nil action:nil];
        UIBarItem* flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
                                                                                 target:nil 
                                                                                 action:nil];
        paymentInfo = [[PaymentInfo alloc] init];
        topBar = [[UIToolbar alloc] initWithFrame:CGRectZero];
        [topBar setItems:[NSArray arrayWithObjects:cancel, flexibleSpace, done, nil]];
        [self addSubview:topBar];
        cardholderNameField = [[UITextField alloc] initWithFrame:CGRectZero];
        [cardholderNameField setBorderStyle:UITextBorderStyleRoundedRect];
        [cardholderNameField setEnablesReturnKeyAutomatically:YES];
        [cardholderNameField setReturnKeyType:UIReturnKeyNext];
        [cardholderNameField setPlaceholder:@"Card Holder Name"];
        [cardholderNameField setDelegate:self];
        [self addSubview:cardholderNameField];
        cardnumberField = [[UITextField alloc] initWithFrame:CGRectZero];
        [cardnumberField setBorderStyle:UITextBorderStyleRoundedRect];
        [cardnumberField setEnablesReturnKeyAutomatically:YES];
        [cardnumberField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
        [cardnumberField setReturnKeyType:UIReturnKeyNext];
        [cardnumberField setPlaceholder:@"Credit Card #"];
        [cardnumberField setDelegate:self];
        [cardnumberField setRightViewMode:UITextFieldViewModeAlways];
        [self addSubview:cardnumberField];
        expirationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [expirationLabel setText:@"Expiry Date"];
        [self addSubview:expirationLabel];
        expiration = [[UIPickerView alloc] initWithFrame:CGRectZero];
        [expiration setDelegate:self];
        [expiration setDataSource:self];
        [expiration setShowsSelectionIndicator:YES];
        [self addSubview:expiration];
    }
    return self;
}

-(void)layoutSubviews{
    CGRect frame = [self bounds];
    NSInteger adjusted = frame.size.width - 2*InterFieldPadding;
    
    [topBar setFrame:(CGRect){
        .size = {
            .width = frame.size.width,
            .height = UIToolbarHeight
        }
    }];
    
    [cardholderNameField setFrame:(CGRect){
        .origin = {
            .x = InterFieldPadding,
            .y = InterFieldPadding + UIToolbarHeight
        },
        .size = {
            .width = adjusted,
            .height = TextFieldHeight
        }
    }];
    [cardnumberField setFrame:(CGRect){
        .origin = {
            .x = InterFieldPadding,
            .y = InterFieldPadding*2 + TextFieldHeight + UIToolbarHeight,
        },
        .size = {
            .width = adjusted,
            .height = TextFieldHeight
        }
    }];
    [expirationLabel sizeToFit];
    CGRect labelFrame = [expirationLabel frame];
    [expirationLabel setFrame:(CGRect){
        .origin = {
            .x = InterFieldPadding,
            .y = 3*InterFieldPadding + 2*TextFieldHeight + UIToolbarHeight
        },
        .size = {
            .width = adjusted,
            .height = labelFrame.size.height
        }
    }];
    [expiration setFrame:(CGRect){
        .origin = {
            .x = InterFieldPadding,
            .y = InterFieldPadding*3 + TextFieldHeight*2 + labelFrame.size.height + LabelFieldPadding + UIToolbarHeight
        },
        .size = {
            .width = adjusted,
            .height = 162
        }
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark UITextFieldDelegate    

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    if(textField == cardholderNameField){
        [cardnumberField becomeFirstResponder];
        return YES;
    } else if(textField == cardnumberField) {
        NSString* errorMessage = nil;
        [paymentInfo setCardnumber:[cardnumberField text] withValidationMessage:&errorMessage];
        if(errorMessage){
            UILabel* errorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            [errorLabel setText:errorMessage];
            [errorLabel sizeToFit];
            [cardnumberField setRightView:errorLabel];
            return NO;
        }
        if([[cardholderNameField text] length]){
            [cardnumberField resignFirstResponder];
        } else {
            [cardholderNameField becomeFirstResponder];
        }
        return YES;
    } else {
        NSAssert(NO, @"Got a message from a random text field!");
        return NO;
    }
}

#pragma mark UIPickerDataSource

typedef enum PickerSections{
    Month,
    Year,
    NumberOfPickerSections
} PickerSections;

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return NumberOfPickerSections;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case Month:
            return 12;
        case Year:
            return 10;
        default:
            NSAssert(NO, @"Impossible index passed in %d", component);
            return -1;
    }
}

#pragma mark UIPickerViewDelegate

-(NSInteger)monthForRow:(NSInteger)row{
    return row + 1;
}

-(NSInteger)yearForRow:(NSInteger)row{
    NSInteger currentYear = [[[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:[NSDate new]] year];
    return currentYear + row;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case Month:
            return [NSString stringWithFormat:@"%2d", row+1];
        case Year:
        {
            return [NSString stringWithFormat:@"%4d", [self yearForRow:row]];
        }   
        default:
            NSAssert(NO, @"Impossible index passed in %d", component);
            return nil;
    }
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}

-(BOOL)respondsToSelector:(SEL)aSelector{
    BOOL superVal = [super respondsToSelector:aSelector];
    NSLog(@"Do we respond to %@? %d", NSStringFromSelector(aSelector), superVal);
    return superVal;
}

@end
