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
#define TextFieldHeight 25
#define LabelFieldPadding 2
#define InterFieldPadding 8

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
        [topBar setItems:[NSArray arrayWithObjects:cancel, flexibleSpace, done, nil]];
        [self addSubview:topBar];
        
        serverErrorMessageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [serverErrorMessageLabel setFont:[UIFont systemFontOfSize:16]];
        [serverErrorMessageLabel setNumberOfLines:1];
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
        
        cardnumberLabel = [PaymentView nameLabel:@"Card Number"];
        [self addSubview:cardnumberLabel];
        
        cardnumberErrorLabel = [PaymentView errorLabel];
        [self addSubview:cardnumberErrorLabel];
        
        cardnumberField = [[UITextField alloc] initWithFrame:CGRectZero];
        [cardnumberField setBorderStyle:UITextBorderStyleRoundedRect];
        [cardnumberField setKeyboardType:UIKeyboardTypeNumberPad];
        [cardnumberField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [cardnumberField setPlaceholder:@"Credit Card #"];
        [cardnumberField setDelegate:self];
        [cardnumberField setRightViewMode:UITextFieldViewModeAlways];
        [self addSubview:cardnumberField];
        
        rememberLabel = [PaymentView nameLabel:@"Remember Info"];
        [self addSubview:rememberLabel];

        remember = [[UISwitch alloc] initWithFrame:CGRectZero];
        [remember setOn:[paymentInfo remember]];
        [remember addTarget:self action:@selector(rememberChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:remember];

        expirationLabel = [PaymentView nameLabel:@"Expiry Date"];
        [self addSubview:expirationLabel];
        
        expirationErrorLabel = [PaymentView errorLabel];
        [self addSubview:expirationErrorLabel];
        
        NSDateFormatter* formatter = [NSDateFormatter new];
        NSDate* today = [NSDate date];

        [formatter setDateFormat:@"MM"];
        expirationMonth = [[UITextField alloc] initWithFrame:CGRectZero];
        [expirationMonth setBorderStyle:UITextBorderStyleRoundedRect];
        [expirationMonth setKeyboardType:UIKeyboardTypeNumberPad];
        [expirationMonth setClearButtonMode:UITextFieldViewModeWhileEditing];
        [expirationMonth setPlaceholder:[formatter stringFromDate:today]];
        [expirationMonth setDelegate:self];
        [self addSubview:expirationMonth];

        [formatter setDateFormat:@"yyyy"];
        expirationYear = [[UITextField alloc] initWithFrame:CGRectZero];
        [expirationYear setBorderStyle:UITextBorderStyleRoundedRect];
        [expirationYear setKeyboardType:UIKeyboardTypeNumberPad];
        [expirationYear setClearButtonMode:UITextFieldViewModeWhileEditing];
        [expirationYear setPlaceholder:[formatter stringFromDate:today]];
        [expirationYear setDelegate:self];
        [self addSubview:expirationYear];
    }
    return self;
}

-(void)layoutSubviews{
    CGRect frame = [self bounds];
    NSInteger adjustedWidth = frame.size.width - 2*InterFieldPadding;
    
    NSInteger (^layoutLabels)(NSInteger, UILabel*, UILabel*, NSInteger,NSInteger) =
    ^(NSInteger height, UILabel* label, UILabel* errorLabel, NSInteger x,NSInteger width){
        [label sizeToFit];
        CGRect leftFrame = [label frame];
        [errorLabel sizeToFit];
        CGRect rightFrame = [errorLabel frame];
        CGFloat maxHeight = MAX(leftFrame.size.height,rightFrame.size.height);
        height += maxHeight;
        leftFrame.origin.y = height - leftFrame.size.height;
        leftFrame.origin.x = x;
        rightFrame.origin.y = height - rightFrame.size.height;
        rightFrame.origin.x = (x+width) - rightFrame.size.width;
        [label setFrame:leftFrame];
        [errorLabel setFrame:rightFrame];
        height += LabelFieldPadding;
        return height;
    };
    
    NSInteger (^layoutWidget)(NSInteger, UIView*, NSInteger, NSInteger,NSInteger)=
    ^(NSInteger height, UIView* widget, NSInteger setHeight, NSInteger x,NSInteger width){
        [widget setFrame:(CGRect){
            .origin = {
                .x = x,
                .y = height
            },
            .size = {
                .width = width,
                .height = setHeight
            }
        }];
        height += setHeight + InterFieldPadding;
        return height;
    };
    
    NSInteger height = 0;
    
    height = layoutWidget(height, topBar, UIToolbarHeight, 0, frame.size.width);
    
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

    height = layoutLabels(height, cardholderNameLabel, cardholderNameErrorLabel,
                          InterFieldPadding, adjustedWidth);
    height = layoutWidget(height, cardholderNameField, TextFieldHeight,
                          InterFieldPadding, adjustedWidth);
    
    height = layoutLabels(height, cardnumberLabel, cardnumberErrorLabel,
                          InterFieldPadding, adjustedWidth);
    height = layoutWidget(height, cardnumberField, TextFieldHeight,
                          InterFieldPadding, adjustedWidth);

    [rememberLabel sizeToFit];
    NSInteger leftWidth = MAX([rememberLabel frame].size.width,
                              [remember frame].size.width);
    NSInteger midpoint = InterFieldPadding*2 + leftWidth;
    NSInteger rightWidth = frame.size.width - InterFieldPadding - midpoint;
    NSInteger leftHeight = layoutLabels(height, rememberLabel, nil,
                                        InterFieldPadding, leftWidth);
    NSInteger rightHeight = layoutLabels(height, expirationLabel,expirationErrorLabel,
                                         midpoint, rightWidth);
    height = MAX(leftHeight, rightHeight);
    leftHeight = layoutWidget(height, remember, [remember frame].size.height, 
                              InterFieldPadding, leftWidth);
    NSInteger threeQuarters = midpoint + rightWidth/2 + InterFieldPadding/2;
    NSInteger halfRightWidth = rightWidth/2 - InterFieldPadding/2;
    layoutWidget(height, expirationMonth, TextFieldHeight,
                               midpoint, halfRightWidth);
    layoutWidget(height, expirationYear, TextFieldHeight,
                               threeQuarters, halfRightWidth);
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
    [paymentInfo setExpirationMonth:[expirationMonth text]];
    [self setErrorMessage:[paymentInfo expirationError] onErrorLabel:expirationErrorLabel];
}

-(void)flushExpirationYear{
    [paymentInfo setExpirationYear:[expirationYear text]];
    [self setErrorMessage:[paymentInfo expirationError] onErrorLabel:expirationErrorLabel];
}

-(void)rememberChanged:(UISwitch*)rememberSwitch{
    [paymentInfo setRemember:[rememberSwitch isOn]];
}

#pragma mark UITextFieldDelegate    

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    if(textField == cardholderNameField){
        [self flushCardholderName];
        [cardnumberField becomeFirstResponder];
    } else if(textField == cardnumberField) {
        [self flushCardnumber];
        [expirationMonth becomeFirstResponder];
    } else if(textField == expirationMonth) {
        [expirationYear becomeFirstResponder];
        [self flushExpirationMonth];
    } else if(textField == expirationYear) {
        [self flushExpirationYear];
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
    } else if(textField == expirationMonth){
        [self flushExpirationMonth];
    } else if(textField == expirationYear){
        [self flushExpirationYear];
    } else {
        NSAssert(NO, @"Got a message from a random text field (%@) !", textField);
    }
}

-(void)textFieldDidBeginEditing:(UITextField*)textField{
    if(textField == cardholderNameField){
        [self setErrorMessage:nil onErrorLabel:cardholderNameErrorLabel];
    } else if(textField == cardnumberField){
        [self setErrorMessage:nil onErrorLabel:cardnumberErrorLabel];
    } else if(textField == expirationMonth){
        [self setErrorMessage:nil onErrorLabel:expirationErrorLabel];
    } else if(textField == expirationYear){
        [self setErrorMessage:nil onErrorLabel:expirationErrorLabel];
    } else {
        NSAssert(NO, @"Got a message from a random text field (%@) !", textField);
    }
}

-(BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSInteger finalSize = [[textField text] length] + [string length] - range.length;
    NSLog(@"FINALSIZE: %i", finalSize);
    if(textField == cardnumberField && finalSize >= 16){
        [expirationMonth performSelectorOnMainThread:@selector(becomeFirstResponder) 
                                          withObject:nil 
                                       waitUntilDone:NO];
    } else if(textField == expirationMonth && finalSize >= 2){
        [expirationYear performSelectorOnMainThread:@selector(becomeFirstResponder) 
                                         withObject:nil 
                                      waitUntilDone:NO];
    }
    return YES;
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
