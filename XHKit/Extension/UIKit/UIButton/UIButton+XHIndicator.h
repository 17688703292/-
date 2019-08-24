//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (XHIndicator)

/**
 This method will show the activity indicator in place of the button text.
 */
- (void)xh_showIndicator;

/**
 This method will remove the indicator and put thebutton text back in place.
 */
- (void)xh_hideIndicator;

@end
