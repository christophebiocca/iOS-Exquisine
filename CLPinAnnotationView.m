//
//  CLPinAnnotationView.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CLPinAnnotationView.h"
#import "CLCalloutView.h"

@implementation CLPinAnnotationView

@synthesize titleLabel, subtitleLabel;

- (id)initWithAnnotation:(id )annotation reuseIdentifier:(NSString *)reuseIdentifier
{   
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    int annotationWidth = 240;
    int xLabelOffset = 10;
    int yLabelOffset = 5;
    int spaceBetweenLabels = 5;
    int labelBuffer = xLabelOffset + yLabelOffset;
    int spikeHeight = 20;
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(xLabelOffset, yLabelOffset, annotationWidth - 2 * xLabelOffset, 20)];
    titleLabel.text = [annotation title];
    titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
    titleLabel.shadowOffset = CGSizeMake(0, -1.0);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    titleLabel.numberOfLines = 3;
    
    CGSize titleLabelSize = [[annotation title] sizeWithFont: titleLabel.font constrainedToSize: CGSizeMake(annotationWidth - 2 * xLabelOffset, 600) lineBreakMode: titleLabel.lineBreakMode];
    titleLabel.frame = CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y, titleLabelSize.width, titleLabelSize.height);
    
    // create subtitle label and size to text
    
    subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(xLabelOffset, titleLabel.frame.size.height + spaceBetweenLabels + yLabelOffset, annotationWidth - 2 * xLabelOffset, 20)];
    subtitleLabel.text = [annotation subtitle];
    subtitleLabel.textAlignment = UITextAlignmentLeft;
    subtitleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
    subtitleLabel.textColor = [UIColor whiteColor];
    subtitleLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
    subtitleLabel.shadowOffset = CGSizeMake(0, -1.0);
    subtitleLabel.backgroundColor = [UIColor clearColor];
    subtitleLabel.lineBreakMode = UILineBreakModeWordWrap;
    subtitleLabel.numberOfLines = 5;
    
    CGSize subtitleLabelSize = [[annotation subtitle] sizeWithFont: subtitleLabel.font constrainedToSize: CGSizeMake(annotationWidth - 2 * xLabelOffset, 600) lineBreakMode: subtitleLabel.lineBreakMode];
    subtitleLabel.frame = CGRectMake(subtitleLabel.frame.origin.x, subtitleLabel.frame.origin.y, subtitleLabelSize.width, subtitleLabelSize.height);
    
    // create callout view to be shown once a annotation view is selected
    
    calloutView = [[CLCalloutView alloc] initWithFrame:CGRectMake(0, 0, annotationWidth, titleLabel.frame.size.height + subtitleLabel.frame.size.height + labelBuffer + spikeHeight) AndSpikeHeight: spikeHeight];
    
    [calloutView addSubview:titleLabel];
    [calloutView addSubview:subtitleLabel];
    
    // position callout above pin
    
    calloutView.frame = CGRectMake(-(annotationWidth/2) + 15 , -calloutView.frame.size.height, calloutView.frame.size.width, calloutView.frame.size.height);
    
    [calloutView setHidden:YES];
    
    [self addSubview:calloutView];
    
    
    return self;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (selected) {
        [calloutView animateIn];
    }
    else
    {
        [calloutView animateOut];
    }
    
}

@end
