//
//  PaymentView.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentView.h"
#import "PaymentInfo.h"

#define TextFieldHeight 25
#define LabelFieldPadding 2
#define InterFieldPadding 8

@implementation PaymentView

@synthesize cardholderNameField, cardholderNameErrorLabel;
@synthesize cardnumberField, cardnumberErrorLabel;
@synthesize remember, showRemember;
@synthesize expirationMonth, expirationYear, expirationErrorLabel;

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
        [cardnumberField setRightViewMode:UITextFieldViewModeAlways];
        [self addSubview:cardnumberField];
        
        rememberLabel = [PaymentView nameLabel:@"Remember Info"];
        [self addSubview:rememberLabel];

        remember = [[UISwitch alloc] initWithFrame:CGRectZero];
        [remember setOn:NO];
        [self addSubview:remember];
        showRemember = YES;

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
        [self addSubview:expirationMonth];

        [formatter setDateFormat:@"yyyy"];
        expirationYear = [[UITextField alloc] initWithFrame:CGRectZero];
        [expirationYear setBorderStyle:UITextBorderStyleRoundedRect];
        [expirationYear setKeyboardType:UIKeyboardTypeNumberPad];
        [expirationYear setClearButtonMode:UITextFieldViewModeWhileEditing];
        [expirationYear setPlaceholder:[formatter stringFromDate:today]];
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

    NSInteger leftWidth;
    NSInteger rightHeight;
    NSInteger rightWidth;
    NSInteger midpoint;
    if(showRemember){
        [rememberLabel sizeToFit];
        rightWidth = MAX([rememberLabel frame].size.width,
                                   [remember frame].size.width);
        midpoint = frame.size.width - InterFieldPadding - rightWidth;
        rightHeight = layoutLabels(height, rememberLabel, nil,
                                   midpoint, rightWidth);
    } else {
        rightWidth = 0;
        rightHeight = 0;
        midpoint = frame.size.width;
    }
    
    leftWidth = midpoint - 2*InterFieldPadding;

    NSInteger leftHeight = layoutLabels(height, expirationLabel,expirationErrorLabel,
                                        InterFieldPadding, leftWidth);

    height = MAX(leftHeight, rightHeight);
    if(showRemember){
        rightHeight = layoutWidget(height, remember, [remember frame].size.height, 
                                   midpoint, rightWidth);
    }
    NSInteger oneQuarter = InterFieldPadding * 1.5 + leftWidth/2;
    NSInteger halfLeftWidth = leftWidth/2 - InterFieldPadding/2;
    layoutWidget(height, expirationMonth, TextFieldHeight,
                               InterFieldPadding, halfLeftWidth);
    layoutWidget(height, expirationYear, TextFieldHeight,
                               oneQuarter, halfLeftWidth);
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

-(void)setErrorMessage:(NSString*)message{
    [serverErrorMessageLabel setText:message];
    [serverErrorMessageLabel setHidden:NO];
    [self setNeedsLayout];
}

-(void)setShowRemember:(BOOL)newShowRemember{
    if(newShowRemember == showRemember) return;
    showRemember = newShowRemember;
    [remember setHidden:!showRemember];
    [rememberLabel setHidden:!showRemember];
    [self setNeedsLayout];
}

@end
