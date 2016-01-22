//
//  b6luxLoadingView.h
//  Zombie Joe
//
//  Created by Slavian on 2013-07-30.
//
//

#import <UIKit/UIKit.h>

@interface b6luxLoadingView : UIView <UIApplicationDelegate>
{
    
}

+(instancetype) loadingViewWithLoadingType:(NSInteger) type;
+(BOOL) removeLoadingView;

//+(instancetype) loadingViewInSuperView:(UIView*) superView loadingType:(NSInteger) type;
//+(BOOL) removeLoadingViewFromSuperView:(UIView*) superView;

- (id)initWithFrame:(CGRect)frame loading:(int)loading;
- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
- (void)loadingON;
@end
