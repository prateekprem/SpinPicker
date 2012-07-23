//
//  Test.h
//  SlotMAchine
//
//  Created by RAVI DAS on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPSpinWheelView.h"
@interface Test : UIViewController<PPSpinWheelDataSource,PPSpinWheelDelegate>
{
    NSMutableArray *images1;
    NSMutableArray *images2;
    PPSpinWheelView *pp;
}
@end
