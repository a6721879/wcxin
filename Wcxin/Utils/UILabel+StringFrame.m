//
//  UILabel+StringFrame.m
//  Wcxin
//
//  Created by chengzi on 15/10/29.
//  Copyright © 2015年 fosung. All rights reserved.
//

#import "UILabel+StringFrame.h"

@implementation UILabel (StringFrame)
- (CGSize)boundingRectWithSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    CGSize retSize = [self.text boundingRectWithSize:size
                                             options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading 
                                          attributes:attribute 
                                             context:nil].size; 
    return retSize; 
}

@end
