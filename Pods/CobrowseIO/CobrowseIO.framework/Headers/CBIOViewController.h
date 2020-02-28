#import <UIKit/UIKit.h>

#import "CobrowseIODelegate.h"

@class CBIOSession;

@interface CBIOViewController : UIViewController

-(instancetype) loadSession: (NSString*) codeOrId;

-(IBAction) accceptSession:(id)sender;
-(IBAction) declineSession:(id)sender;
-(IBAction) endSession:(id)sender;

@end
