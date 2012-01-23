//
//  AlertPrompt.h
//  Prompt
//

#import <Foundation/Foundation.h>

@interface AlertPrompt : UIAlertView 
{
    UITextField *textField;
}
@property (nonatomic, retain) UITextField *textField;

- (id)initWithPromptTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okButtonTitle;

- (NSString *)enteredText;

@end