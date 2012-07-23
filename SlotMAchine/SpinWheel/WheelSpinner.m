//
//  WheelSpinner.m
//  SpinWheel
//

#import "WheelSpinner.h"
#import <QuartzCore/QuartzCore.h>
#include "math.h"
#import "Constents.h"
//#define USENUMBERS	1



#include "AppDelegate.h"


@implementation UIView (UIViewCategory)

-(UIImage*)convertInImage
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end

@implementation UIImageView (UIImageViewCategory)

-(id)copyWithZone:(NSZone*)zone
{
    UIImageView *img = [[UIImageView alloc]initWithImage:[self.image copyWithZone:zone]];
    return img;
}

@end

@implementation UIImage (UIImageCategory)

-(id)copyWithZone:(NSZone*)zone
{
    UIImage *img = [[UIImage alloc]initWithCGImage:self.CGImage];
    return img;
}

@end

@implementation WheelSpinner


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        UIView *subView = [[[NSBundle mainBundle] loadNibNamed:@"WheelSpinner" owner:self options:nil]objectAtIndex:0];
        subView.frame = self.bounds;
        [self addSubview:subView];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.animationDuration = (int) random() % 20;
    }
    return self;
}

- (void)adjustFrame:(CGRect)frame {
    
        self.frame = frame;
		
    if(!self.images)self.images = [[NSMutableArray alloc]init];
        // Initialization code
		//
		_stopSpin = NO;
		_spinning = NO;
		self.maxImageIndex = self.maxImages-1;
		
		self.glossLayer = [[UIImageView alloc] initWithFrame:self.bounds];
		self.glossLayer.backgroundColor = [UIColor clearColor];
        self.glossLayer.image = [UIImage imageNamed:Slot];
        UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,self.center.y-15,frame.size.width,29)];
        lineImage.backgroundColor = [UIColor clearColor];
        lineImage.image = [UIImage imageNamed:Line];
        [self.glossLayer addSubview:lineImage];
		[self addSubview:self.glossLayer];
		//self.contentMode = UIViewContentModeTopLeft;
		self.currentPosition = 0;
		self.maxTimeout = 30;
		self.currentSpin = 0;
		self.spinAnimation = [CABasicAnimation animationWithKeyPath:@"contentsRect"];
		self.spinAnimation.removedOnCompletion = NO;
		self.spinAnimation.fillMode = kCAFillModeForwards;
		self.spinAnimation.duration = 1.0;
		self.spinAnimation.delegate = self;
    
        if(self.noOfItemOnScreen == 1)
            self.currentDisplayRect = CGRectMake(0.0, 0.0, 1.0, VIEWPORTINCREMENT(self.maxImages));		
        else
            self.currentDisplayRect = CGRectMake(0.0, 0.02, 1.0, VIEWPORTINCREMENT(self.maxImages*1.2));		
    
		self.layer.contentsRect = self.currentDisplayRect;

        
}


-(void)loadImages
{
    
    
    UIImageView *rowImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    int y = 0;
    
    
    for(UIImageView *imgView in self.images)
    {
       CGRect rect =  CGRectMake(0, y, self.frame.size.width, imgView.frame.size.height);
        imgView.frame = rect;
        UIImageView *i = [[UIImageView alloc]initWithImage:[[UIImage alloc]initWithCGImage:imgView.image.CGImage]];
        i.frame = rect;
        [rowImageView addSubview:i];
        rowImageView.frame = CGRectMake(0, y, self.frame.size.width, rect.size.height+y);

        y+= imgView.frame.size.height;
    }
    
    if(self.noOfItemOnScreen <= 1) goto jump;
    
    for(UIImageView *imgView in self.images)
    {
        CGRect rect =  CGRectMake(0, y, self.frame.size.width, imgView.frame.size.height);
        imgView.frame = rect;
        UIImageView *i = [[UIImageView alloc]initWithImage:[[UIImage alloc]initWithCGImage:imgView.image.CGImage]];
        i.frame = rect;
        [rowImageView addSubview:i];
        rowImageView.frame = CGRectMake(0, y, self.frame.size.width, rect.size.height+y);
        y+= imgView.frame.size.height;
       
    }
    
jump:
    {    
        UIImage *img = [rowImageView convertInImage];
        [self setImage:img];
    }
    

}

// Starts at 0
//
- (void) setWheelTo:(NSUInteger)position startAt:(NSInteger)startAt animate:(BOOL)animate
{
	_spinning = YES;
	
	// If we've reached the bottom of the strip, we turn off animated value changes,
	// step the displayrect back up to the top and re-enable animations.
	//
	if (self.currentPosition == (self.maxImageIndex) && position == 0 && !animate) {
		[CATransaction setDisableActions:YES];
		self.currentDisplayRect = CGRectMake(0.0, 0.0, 1.0, VIEWPORTINCREMENT(self.maxImages));
		self.layer.contentsRect = self.currentDisplayRect;
		[CATransaction setDisableActions:NO];
	} else 
		// This one's for when going backwards...
		if (self.currentPosition == 0 && position == (self.maxImageIndex) && !animate) {
			[CATransaction setDisableActions:YES];
			self.currentDisplayRect = CGRectMake(0.0, 0.0, 1.0, VIEWPORTINCREMENT(self.maxImages));
			self.layer.contentsRect = self.currentDisplayRect;
			[CATransaction setDisableActions:NO];
        }
	
	
	if (startAt >= 0) {
		[CATransaction setDisableActions:YES];
        
         if(self.noOfItemOnScreen == 1)
             self.currentDisplayRect = CGRectMake(0.0, ((startAt)*VIEWPORTINCREMENT(self.maxImages)), 1.0, VIEWPORTINCREMENT(self.maxImages));
        else
            self.currentDisplayRect = CGRectMake(0.0, ((startAt)*VIEWPORTINCREMENT(self.maxImages)), 1.0, VIEWPORTINCREMENT(self.maxImages*1.5));
		self.layer.contentsRect = self.currentDisplayRect;
		[CATransaction setDisableActions:NO];
	}		
	
	CGRect newDisplayRect;
    if(self.noOfItemOnScreen == 1)
        newDisplayRect = CGRectMake(0.0, position*VIEWPORTINCREMENT(self.maxImages), 1.0, VIEWPORTINCREMENT(self.maxImages));
    else
    {
    if(position != 0)
        newDisplayRect = CGRectMake(0.0, (position-1)*VIEWPORTINCREMENT(self.maxImages*.5), 1.0, VIEWPORTINCREMENT(self.maxImages*1.5));
    else
        newDisplayRect = CGRectMake(0.0, self.maxImageIndex*VIEWPORTINCREMENT(self.maxImages*.5), 1.0, VIEWPORTINCREMENT(self.maxImages*1.5));
    }
	self.spinAnimation.fromValue = [NSValue valueWithCGRect:self.currentDisplayRect];
	self.spinAnimation.toValue = [NSValue valueWithCGRect:newDisplayRect];	
	//	self.spinAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	[self.layer addAnimation:self.spinAnimation forKey:nil];
	self.currentDisplayRect = newDisplayRect;
	self.currentPosition = position;
}

// Called when each animation has concluded. It will either fire off another one or 
// stop and clean up. If done, it calls back the delegate and tells it what
// number it ended up with.

-(void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)finished
{
	NSInteger stopCount = 0;

	// Let's ignore coreanimation completions for other elements in the UI.
	//
	if (!_spinning)
		return;
	
	if (self.spinCount >= self.spinMax && finished) {
		CALayer *layer = self.layer;
		NSString *path = [self.spinAnimation keyPath];
		[layer setValue:[self.spinAnimation toValue] forKeyPath:path];
		[layer removeAnimationForKey:path];

		// Notify the delegate we're done and return the number we came up with (between 0 < imageCount).
		//
		
		if (_spinDelegate)
        {
            //NSLog(@"self.currentPosition = %d",self.currentPosition);
            [_spinDelegate SpinningEndedOfComponent:self AtIndex:_finalCounter];
			//[_spinDelegate SpinningEndedOfComponent:self AtIndex:(_finalCounter*(self.spinCount%3)-1)%self.maxImages];
        }
	} else {
		// On any complete spin that's past the first one but not the last one, we do linear animation.
		//
		if (_spinMax > 0 && self.spinCount < self.spinMax-1) {
			self.spinAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
			stopCount = self.maxImageIndex;
			
		} else {
			// On the very last spin, we stop at the pre-determined value and do an ease-out animation.
			//
			stopCount = _finalCounter;
			self.spinAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            
		}
		self.spinCount++;
		[self setWheelTo:stopCount startAt:0 animate:NO];
	}
}

- (void) spinWheel:(NSInteger)count
{
    
    _stopSpin = NO;
    _spinning = NO;
    self.currentSpin = 0;
    self.spinCount=0;
    _finalCounter=0;
    _spinMax=0;
    self.spinCount=0;
    self.spinMax=0;
    
     if(self.maxImages<1)return;
	_spinning = YES;
	
	// We try to randomize the duration of the animation slightly.
	// The base animation for running a whole strip from top to bottom is 1 second.
	// We create a random number between 1 and 20. If it's less than 10, we deduct
	// 1/100 sec * number from the baseline. If it's more than 10, we add to it (to slow it down).
	// 
	
	BOOL slower = NO;
	NSInteger durationSeed =  self.animationDuration;
	if (durationSeed > 10)
		slower = YES;
	
	CGFloat adder = (CGFloat) durationSeed / 50.0;
	CGFloat newDuration = slower ? 1.0 + adder : 1.0 - adder;
	self.spinAnimation.duration = newDuration;
	
	if (count <= 0) {
		self.spinMax = (int) (random() % MAXROTATION);
		if (self.spinMax < MINROTATION)
			self.spinMax = MINROTATION;
	} else
		self.spinMax = count;
	
	self.spinCount = 0;
	_finalCounter = (int) (random() % self.maxImages);

	self.spinAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
	[self setWheelTo:self.maxImageIndex startAt:-1 animate:YES];
}

- (void) stopWheel
{
	_stopSpin = YES;
	self.spinCount = self.spinMax-1;
}


#pragma mark -
#pragma mark Reel Methods




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)dealloc {
    self.spinAnimation = nil;
    self.glossLayer = nil;
    [super dealloc];
}


@synthesize spinDelegate = _spinDelegate;
@synthesize currentPosition = _currentPosition;
@synthesize maxTimeout = _maxTimeout;
@synthesize currentSpin = _currentSpin;
@synthesize currentDisplayRect = _currentDisplayRect;
@synthesize heightOffsetCoordinate = _heightOffsetCoordinate;
@synthesize spinAnimation = _spinAnimation;
@synthesize glossLayer = _glossLayer;
@synthesize spinMax = _spinMax;
@synthesize spinCount = _spinCount;
@synthesize maxImages = _maxImages;
@synthesize maxImageIndex = _maxImageIndex;
@synthesize images = _images;
@synthesize animationDuration = _animationDuration;
@synthesize noOfItemOnScreen  = _noOfItemOnScreen;

@end
