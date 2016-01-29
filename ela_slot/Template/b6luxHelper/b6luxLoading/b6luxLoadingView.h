//
//  b6luxLoadingView.h
//  Zombie Joe
//
//  Created by Slavian on 2013-07-30.
//
//

#import <UIKit/UIKit.h>

@interface b6luxLoadingView : UIView <UIApplicationDelegate>

+(instancetype) loadingViewWithLoadingType:(NSInteger) type;
+(BOOL) removeLoadingView;
- (id)initWithFrame:(CGRect)frame loading:(int)loading;

@end
