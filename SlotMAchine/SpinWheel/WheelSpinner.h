//
//  WheelSpinner.h
//  SpinWheel
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface UIView (UIViewCategory)
-(UIImage*)convertInImage;
@end

@interface UIImageView (UIImageViewCategory)
-(id)copyWithZone:(NSZone*)zone;
@end

@interface UIImage (UIImageCategory)
-(id)copyWithZone:(NSZone*)zone;
@end


@class WheelSpinner;
@protocol WheelSpinnerDelegate
-(void)SpinningEndedOfComponent:(WheelSpinner*)wheel AtIndex:(NSUInteger)index;
@end

@interface WheelSpinner : UIImageView 
{
	id<NSObject, WheelSpinnerDelegate> _spinDelegate;
	NSUInteger			_currentPosition;
	NSUInteger			_maxTimeout;
	NSUInteger			_currentSpin;
	CGRect				_currentDisplayRect;
	CGFloat				_heightOffsetCoordinate;
	CABasicAnimation*	_spinAnimation;
	IBOutlet UIImageView*		_glossLayer;
	NSUInteger			_spinMax;
	NSUInteger			_spinCount;
	NSUInteger			_maxImages;
	NSUInteger			_maxImageIndex;
	NSUInteger			_finalCounter;
	BOOL				_stopSpin;
	BOOL				_spinning;
    NSTimeInterval     _animationDuration;
    NSMutableArray     *_images;
    NSInteger           _noOfItemOnScreen;
    
}
@property (nonatomic, retain) NSMutableArray *images;
@property (nonatomic, assign) NSInteger noOfItemOnScreen;
@property (nonatomic, assign) IBOutlet id<NSObject, WheelSpinnerDelegate> spinDelegate;
@property (nonatomic, assign) NSTimeInterval     animationDuration;
@property (nonatomic, assign) NSUInteger currentPosition;
@property (nonatomic, assign) NSUInteger maxTimeout;
@property (nonatomic, assign) NSUInteger currentSpin;
@property (nonatomic, assign) CGRect currentDisplayRect;
@property (nonatomic, assign) CGFloat heightOffsetCoordinate;
@property (nonatomic, retain) CABasicAnimation *spinAnimation;
@property (nonatomic, retain) IBOutlet UIImageView *glossLayer;
@property (nonatomic, assign) NSUInteger spinMax;
@property (nonatomic, assign) NSUInteger spinCount;
@property (nonatomic, assign) NSUInteger maxImages;
@property (nonatomic, assign) NSUInteger maxImageIndex;

- (void) setWheelTo:(NSUInteger)position startAt:(NSInteger)startAt animate:(BOOL)animate;
- (void) spinWheel:(NSInteger)count;
- (void) stopWheel;
- (void)adjustFrame:(CGRect)frame;
-(void)loadImages;

@end
