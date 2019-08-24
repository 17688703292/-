//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "XHModel.h"
#import <YYModel.h>

@implementation XHModel

- (NSString *)description {
    return [NSString stringWithFormat:@"\n%@", [self yy_modelDescription]];
}

@end
