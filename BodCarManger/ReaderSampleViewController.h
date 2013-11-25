//
//  ReaderSampleViewController.h
//  ReaderSample
//
//  Created by spadix on 4/14/11.
//

#import <UIKit/UIKit.h>
#import "UIBaseViewController.h"
#import "ZBarSDK.h"
@interface ReaderSampleViewController
    : UIBaseViewController
    // ADD: delegate protocol
    < ZBarReaderDelegate>
{
    UIImageView *resultImage;
    UITextView *resultText;
}
@property (nonatomic, retain) IBOutlet UIImageView *resultImage;
@property (nonatomic, retain) IBOutlet UITextView *resultText;
- (IBAction) scanButtonTapped;
@end
