//
//  PaymentView.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentView.h"
#import "PaymentViewDelegate.h"
#import "PaymentInfo.h"

#define UIToolbarHeight 44
#define TextFieldHeight 30
#define LabelFieldPadding 5
#define InterFieldPadding 15

@implementation PaymentView

@synthesize paymentInfo, delegate;

typedef enum PickerSections{
    Month,
    Year,
    NumberOfPickerSections
} PickerSections;

static UIColor* errorLabelColor;

+(void)initialize{
    if(!errorLabelColor){
        errorLabelColor = [UIColor colorWithRed:0.6 green:0.2 blue:0.2 alpha:1];
    }
}

+(UILabel*)nameLabel:(NSString*)text{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectZero];
    [label setText:text];
    return label;
}

+(UILabel*)errorLabel{
    UILabel* errorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [errorLabel setFont:[UIFont systemFontOfSize:12]];
    [errorLabel setTextColor:errorLabelColor];
    [errorLabel setHidden:YES];
    return errorLabel;
}

- (id)init
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
        cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelled)];
        UIBarItem* flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
                                                                                 target:nil 
                                                                                 action:nil];
        paymentInfo = [[PaymentInfo alloc] init];
        topBar = [[UIToolbar alloc] initWithFrame:CGRectZero];
        [topBar setItems:[NSArray arrayWithObjects:cancel, flexibleSpace, done, nil]];
        [self addSubview:topBar];
        
        cardholderNameLabel = [PaymentView nameLabel:@"Card Holder Name"];
        [self addSubview:cardholderNameLabel];
        
        cardholderNameErrorLabel = [PaymentView errorLabel];
        [self addSubview:cardholderNameErrorLabel];
        
        cardholderNameField = [[UITextField alloc] initWithFrame:CGRectZero];
        [cardholderNameField setBorderStyle:UITextBorderStyleRoundedRect];
        [cardholderNameField setEnablesReturnKeyAutomatically:YES];
        [cardholderNameField setReturnKeyType:UIReturnKeyNext];
        [cardholderNameField setPlaceholder:@"Card Holder Name"];
        [cardholderNameField setDelegate:self];
        [self addSubview:cardholderNameField];
        
        cardnumberLabel = [PaymentView nameLabel:@"Card number"];
        [self addSubview:cardnumberLabel];
        
        cardnumberErrorLabel = [PaymentView errorLabel];
        [self addSubview:cardnumberErrorLabel];
        
        cardnumberField = [[UITextField alloc] initWithFrame:CGRectZero];
        [cardnumberField setBorderStyle:UITextBorderStyleRoundedRect];
        [cardnumberField setEnablesReturnKeyAutomatically:YES];
        [cardnumberField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
        [cardnumberField setReturnKeyType:UIReturnKeyNext];
        [cardnumberField setPlaceholder:@"Credit Card #"];
        [cardnumberField setDelegate:self];
        [cardnumberField setRightViewMode:UITextFieldViewModeAlways];
        [self addSubview:cardnumberField];
        
        expirationLabel = [PaymentView nameLabel:@"Expiry Date"];
        [self addSubview:expirationLabel];
        
        expirationErrorLabel = [PaymentView errorLabel];
        [self addSubview:expirationErrorLabel];
        
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
    NSInteger rightLimit = frame.size.width - InterFieldPadding;
    NSInteger adjustedWidth = frame.size.width - 2*InterFieldPadding;
    __block NSInteger height = 0;
    
    void (^layoutLabels)(UILabel*, UILabel*) = ^(UILabel* label, UILabel* errorLabel){
        [label sizeToFit];
        CGRect leftFrame = [label frame];
        [errorLabel sizeToFit];
        CGRect rightFrame = [errorLabel frame];
        CGFloat maxHeight = MAX(leftFrame.size.height,rightFrame.size.height);
        height += maxHeight;
        leftFrame.origin.y = height - leftFrame.size.height;
        leftFrame.origin.x = InterFieldPadding;
        rightFrame.origin.y = height - rightFrame.size.height;
        rightFrame.origin.x = rightLimit - rightFrame.size.width;
        [label setFrame:leftFrame];
        [errorLabel setFrame:rightFrame];
        height += LabelFieldPadding;
    };
    
    void (^layoutWidget)(UIView*, NSInteger, BOOL)= ^(UIView* widget, NSInteger setHeight, BOOL fullWidth){
        [widget setFrame:(CGRect){
            .origin = {
                .x = fullWidth ? 0 : InterFieldPadding,
                .y = height
            },
            .size = {
                .width = fullWidth ? frame.size.width : adjustedWidth,
                .height = setHeight
            }
        }];
        height += setHeight + InterFieldPadding;
    };
    
    layoutWidget(topBar, UIToolbarHeight, YES);
    
    layoutLabels(cardholderNameLabel, cardholderNameErrorLabel);
    layoutWidget(cardholderNameField, TextFieldHeight, NO);
    
    layoutLabels(cardnumberLabel, cardnumberErrorLabel);
    layoutWidget(cardnumberField, TextFieldHeight, NO);
    
    layoutLabels(expirationLabel, expirationErrorLabel);
    layoutWidget(expiration, 162, YES);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)setErrorMessage:(NSString*)message onErrorLabel:(UILabel*)label{
    if(message){
        [label setText:message];
        [self setNeedsLayout];
    }
    [label setHidden:!message];
}

-(NSInteger)monthForRow:(NSInteger)row{
    return row + 1;
}

-(NSInteger)yearForRow:(NSInteger)row{
    NSInteger currentYear = [[[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:[NSDate new]] year];
    return currentYear + row;
}

-(NSString*)flushCardholderName{
    NSString* error = nil;
    [paymentInfo setCardholderName:[cardholderNameField text] withValidationMessage:&error];
    [self setErrorMessage:error onErrorLabel:cardholderNameErrorLabel];
    return error;
}

-(NSString*)flushCardnumber{
    NSString* error = nil;
    [paymentInfo setCardnumber:[cardnumberField text] withValidationMessage:&error];
    [self setErrorMessage:error onErrorLabel:cardnumberErrorLabel];
    return error;
}

-(NSString*)flushExpirationMonth{
    NSString* error = nil;
    [paymentInfo setExpirationMonth:[self monthForRow:[expiration selectedRowInComponent:Month]] withValidationMessage:&error];
    [self setErrorMessage:error onErrorLabel:expirationErrorLabel];
    return error;
}

-(NSString*)flushExpirationYear{
    NSString* error = nil;
    [paymentInfo setExpirationYear:[self yearForRow:[expiration selectedRowInComponent:Year]] withValidationMessage:&error];
    [self setErrorMessage:error onErrorLabel:expirationErrorLabel];
    return error;
}

#pragma mark UITextFieldDelegate    

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    if(textField == cardholderNameField){
        if(![self flushCardholderName]){
            [cardnumberField becomeFirstResponder];
            return YES;
        }
    } else if(textField == cardnumberField) {
        if(![self flushCardnumber]){
            [cardnumberField resignFirstResponder];
            return YES;
        }
    } else {
        NSAssert(NO, @"Got a message from a random text field!");
    }
    return NO;
}

#pragma mark UIPickerDataSource

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

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case Month:
            return [NSString stringWithFormat:@"%2d", [self monthForRow:row]];
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
    NSString* error = nil;
    for(UITextField* textfield in [NSArray arrayWithObjects:cardholderNameField, cardnumberField, nil]){
        if([textfield isFirstResponder]){
            [textfield resignFirstResponder];
        }
    }
    switch (component) {
        case Year:
            [paymentInfo setExpirationYear:[self yearForRow:row] withValidationMessage:&error];
            break;
        case Month:
            [paymentInfo setExpirationMonth:[self monthForRow:row] withValidationMessage:&error];
            break;    
        default:
            NSAssert(NO, @"Impossible index passed in %d", component);
    }
    if(error){
        [expirationLabel setText:[NSString stringWithFormat:@"Expiry Date (%@)", error]];
    } else {
        [expirationLabel setText:@"Expiry Date"];
    }
}

#pragma mark buttons

-(void)done{
    if(![self flushCardholderName] &&
       ![self flushCardnumber] &&
       ![self flushExpirationYear] &&
       ![self flushExpirationMonth]){
        [delegate paymentDone];
    }
}

-(void)cancelled{
    [delegate paymentCancelled];
}

@end
