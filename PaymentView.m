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
#define LabelFieldPadding 3
#define InterFieldPadding 12

@implementation PaymentView

@synthesize paymentInfo, delegate, deleteButton;

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
    [label setFont:[UIFont systemFontOfSize:15]];
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
        //botBar = [[UIToolbar alloc] initWithFrame:CGRectZero];
        [topBar setItems:[NSArray arrayWithObjects:cancel, flexibleSpace, done, nil]];
        [self addSubview:topBar];
        [self addSubview:botBar];
        
        serverErrorMessageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [serverErrorMessageLabel setFont:[UIFont systemFontOfSize:20]];
        [serverErrorMessageLabel setLineBreakMode:UILineBreakModeWordWrap];
        [serverErrorMessageLabel setNumberOfLines:0];
        [serverErrorMessageLabel setTextColor:errorLabelColor];
        [self addSubview:serverErrorMessageLabel];
        
        cardholderNameLabel = [PaymentView nameLabel:@"Card Holder Name"];
        [self addSubview:cardholderNameLabel];
        
        cardholderNameErrorLabel = [PaymentView errorLabel];
        [self addSubview:cardholderNameErrorLabel];
        
        cardholderNameField = [[UITextField alloc] initWithFrame:CGRectZero];
        [cardholderNameField setBorderStyle:UITextBorderStyleRoundedRect];
        [cardholderNameField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [cardholderNameField setPlaceholder:@"Card Holder Name"];
        [cardholderNameField setDelegate:self];
        [self addSubview:cardholderNameField];
        
        cardnumberLabel = [PaymentView nameLabel:@"Card number"];
        [self addSubview:cardnumberLabel];
        
        cardnumberErrorLabel = [PaymentView errorLabel];
        [self addSubview:cardnumberErrorLabel];
        
        cardnumberField = [[UITextField alloc] initWithFrame:CGRectZero];
        [cardnumberField setBorderStyle:UITextBorderStyleRoundedRect];
        [cardnumberField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
        [cardnumberField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [cardnumberField setPlaceholder:@"Credit Card #"];
        [cardnumberField setDelegate:self];
        [cardnumberField setRightViewMode:UITextFieldViewModeAlways];
        [self addSubview:cardnumberField];
        
        rememberLabel = [PaymentView nameLabel:@"Remember my payment information"];
        [self addSubview:rememberLabel];

        remember = [[UISwitch alloc] initWithFrame:CGRectZero];
        [remember setOn:[paymentInfo remember]];
        [remember addTarget:self action:@selector(rememberChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:remember];

        expirationLabel = [PaymentView nameLabel:@"Expiry Date"];
        [self addSubview:expirationLabel];
        
        expirationErrorLabel = [PaymentView errorLabel];
        [self addSubview:expirationErrorLabel];
        
        expiration = [[UIPickerView alloc] initWithFrame:CGRectZero];
        [expiration setDelegate:self];
        [expiration setDataSource:self];
        [expiration setShowsSelectionIndicator:YES];
        [self addSubview:expiration];
        
        deleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [deleteButton setTitle:@"Forget my credit card now" forState:UIControlStateNormal];
        [self addSubview:deleteButton];
        
    }
    return self;
}

-(void)layoutSubviews{
    CGRect frame = [self bounds];
    [botBar setFrame:CGRectMake(0, 416, 320, 44)];
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
    
    if([[serverErrorMessageLabel text] length]){
        CGSize labelSize = [[serverErrorMessageLabel text]
                            sizeWithFont:[serverErrorMessageLabel font]
                            constrainedToSize:CGSizeMake(adjustedWidth, 9999)
                            lineBreakMode:UILineBreakModeWordWrap];
        [serverErrorMessageLabel setFrame:(CGRect){
            .origin = {
                .x = InterFieldPadding,
                .y = height
            },
            .size = labelSize
        }];

        height += labelSize.height + InterFieldPadding;
    }

    layoutLabels(cardholderNameLabel, cardholderNameErrorLabel);
    layoutWidget(cardholderNameField, TextFieldHeight, NO);
    
    layoutLabels(cardnumberLabel, cardnumberErrorLabel);
    layoutWidget(cardnumberField, TextFieldHeight, NO);
    
    layoutLabels(rememberLabel, nil);
    layoutWidget(remember, [remember frame].size.height, NO);
    
    layoutWidget(deleteButton, 22,NO);

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

-(void)flushCardholderName{
    [paymentInfo setCardholderName:[cardholderNameField text]];
    [self setErrorMessage:[paymentInfo cardholderNameError] onErrorLabel:cardholderNameErrorLabel];
}

-(void)flushCardnumber{
    [paymentInfo setCardnumber:[cardnumberField text]];
    [self setErrorMessage:[paymentInfo cardnumberError] onErrorLabel:cardnumberErrorLabel];
}

-(void)flushExpirationMonth{
    [paymentInfo setExpirationMonth:[self monthForRow:[expiration selectedRowInComponent:Month]]];
    [self setErrorMessage:[paymentInfo expirationError] onErrorLabel:expirationErrorLabel];
}

-(void)flushExpirationYear{
    [paymentInfo setExpirationYear:[self yearForRow:[expiration selectedRowInComponent:Year]]];
    [self setErrorMessage:[paymentInfo expirationError] onErrorLabel:expirationErrorLabel];
}

-(void)rememberChanged:(UISwitch*)rememberSwitch{
    [paymentInfo setRemember:[rememberSwitch isOn]];
}

#pragma mark UITextFieldDelegate    

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    if(textField == cardholderNameField){
        [self flushCardholderName];
        [cardholderNameField resignFirstResponder];
        return YES;
    } else if(textField == cardnumberField) {
        [self flushCardnumber];
        [cardnumberField resignFirstResponder];
    } else {
        NSAssert(NO, @"Got a message from a random text field!");
    }
    return NO;
}

-(void)textFieldDidEndEditing:(UITextField*)textField{
    if(textField == cardholderNameField){
        [self flushCardholderName];
    } else if(textField == cardnumberField){
        [self flushCardnumber];
    } else {
        NSAssert(NO, @"Got a message from a random text field (%@) !", textField);
    }
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
    for(UITextField* textfield in [NSArray arrayWithObjects:cardholderNameField, cardnumberField, nil]){
        if([textfield isFirstResponder]){
            [textfield resignFirstResponder];
        }
    }
    switch (component) {
        case Year:
            [paymentInfo setExpirationYear:[self yearForRow:row]];
            [paymentInfo setExpirationMonth:[self monthForRow:[pickerView selectedRowInComponent:Month]]];
            break;
        case Month:
            [paymentInfo setExpirationMonth:[self monthForRow:row]];
            [paymentInfo setExpirationYear:[self yearForRow:[pickerView selectedRowInComponent:Year]]];
            break;    
        default:
            NSAssert(NO, @"Impossible index passed in %d", component);
    }
    [self setErrorMessage:[paymentInfo expirationError] onErrorLabel:expirationErrorLabel];
}

#pragma mark buttons

-(void)done{
    [cardholderNameField resignFirstResponder];
    [cardnumberField resignFirstResponder];
    [self flushCardholderName];
    [self flushCardnumber];
    [self flushExpirationYear];
    [self flushExpirationMonth];
    if(![paymentInfo anyErrors]){
        [delegate paymentDone];
    }
}

-(void)cancelled{
    [delegate paymentCancelled];
}

-(void)setErrorMessage:(NSString*)message{
    [serverErrorMessageLabel setText:message];
    [serverErrorMessageLabel setHidden:NO];
    [self setNeedsLayout];
}

@end
