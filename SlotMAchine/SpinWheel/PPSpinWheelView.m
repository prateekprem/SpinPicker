//
//  PPSpinWheelView.m
//  SlotMAchine
//
//  Created by RAVI DAS on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PPSpinWheelView.h"

#define Component_Tag 100
#define Row_Tag 1000

#define Default_Row_Height 30;




@implementation PPSpinWheelView

@synthesize delegate = _delegate;
@synthesize dataSource = _dataSource;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



-(void)reloadSpinningWheel
{
    int noOfComponents = [self.dataSource noOfComponentsInPPSpinWheel:self];
    
    float component_margine = 0.0;
    if([self.delegate respondsToSelector:@selector(margineForComponentsInPPSpinWheel:)])
        component_margine = [self.delegate margineForComponentsInPPSpinWheel:self];
    
    CGRect rect = self.bounds;
    CGSize componentSize = CGSizeMake((rect.size.width-(component_margine*(noOfComponents-1)))/noOfComponents, rect.size.height);
    
    if(!components)components = [[NSMutableArray alloc]initWithCapacity:noOfComponents];
    
    int noOfImageToShowOnComponent = 1;
    if([self.delegate respondsToSelector:@selector(noOfViewShowOnComponentsInPPSpinWheel:)])
        noOfImageToShowOnComponent = [self.delegate noOfViewShowOnComponentsInPPSpinWheel:self];
    
    WheelSpinner *wheelSpinner;
    CGFloat x=0;

    for(int component = 0 ; component < noOfComponents; component++)
    {
        wheelSpinner = [[WheelSpinner alloc] init ];
        wheelSpinner.spinDelegate = self;
        wheelSpinner.noOfItemOnScreen = noOfImageToShowOnComponent;
        wheelSpinner.tag = Component_Tag+component;
        wheelSpinner.maxImages = [self.dataSource PPSpinWheelView:self noOfRowsInComponent:component];
        
        
        
        if([self.delegate respondsToSelector:@selector(PPSpinWheelView:spinDurationForComponent:)])
            wheelSpinner.animationDuration = [self.delegate PPSpinWheelView:self spinDurationForComponent:component];
        
        [wheelSpinner adjustFrame:CGRectMake(x, 0, componentSize.width, componentSize.height)];
        int y = 0;
        for(int row = 0; row < wheelSpinner.maxImages; row++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:component];
            UIImageView *view;
            if([self.delegate respondsToSelector:@selector(PPSpinWheelView:viewForRowAtIndexPath:)])
               view = (UIImageView*)[self.delegate PPSpinWheelView:self viewForRowAtIndexPath:indexPath];
           
            if(!view)
                view = [[UIImageView alloc]init];
            
            view.backgroundColor = [UIColor blueColor];
             view.tag = Row_Tag + row;
            
            float rowHeight = 0.0;
            if([self.delegate respondsToSelector:@selector(PPSpinWheelView:heightForRowAtIndexPath:)])
                rowHeight = [self.delegate PPSpinWheelView:self heightForRowAtIndexPath:indexPath];
            
            if(rowHeight<=0)rowHeight = view.frame.size.height;
            
            CGRect viewRect = CGRectMake(0, y, componentSize.width, rowHeight);
            view.frame = viewRect;
            
            [wheelSpinner.images addObject:view];
            y += rowHeight;
        
        }
        
        [wheelSpinner adjustFrame:CGRectMake(x, 0, componentSize.width, componentSize.height)];
        [wheelSpinner loadImages];
        
        [self addSubview:wheelSpinner];
        
        x+=(componentSize.width+component_margine);
    }
    
}


-(void)spinComponentAtIndex:(NSInteger)index
{
    WheelSpinner *component = (WheelSpinner*)[self viewWithTag:Component_Tag+index];
    
    [component spinWheel:-1];
    
}

-(void)spinAllComponents
{
    
    for(UIView *wheel in self.subviews)
        if([wheel isKindOfClass:[WheelSpinner class]])
            [(WheelSpinner*)wheel spinWheel:[(WheelSpinner*)wheel animationDuration]/6];
            //[(WheelSpinner*)wheel spinWheel:(int) FLT_MAX];
}



-(void)SpinningEndedOfComponent:(WheelSpinner*)wheel AtIndex:(NSUInteger)index
{
    [wheel stopWheel];
    if(self.delegate)
    { 
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:wheel.tag-Component_Tag];
        [self.delegate spinEndedWithIndexPath:indexPath];
    }
        
    
}

/*
- (void) setIndex:(int) index {
	_index = index;
}

- (int) index {
	return _index;
}



- (IBAction) moveDown:(id)sender
{
	if (_count < 9)
		_count++;
	else
		_count = 0;
	
	[self.wheel setWheelTo:_count startAt:-1 animate:YES];
}

- (IBAction) moveUp:(id)sender
{
	if (_count > 0)
		_count--;
	else
		_count = 9;
	
	[self.wheel setWheelTo:_count startAt:-1 animate:YES];
}

- (IBAction) doSpin:(id)sender
{
	[self.wheel spinWheel:-1];
}

- (IBAction) doSpinForever:(id)sender
{
	[self.wheel spinWheel:(int) FLT_MAX];
}

- (IBAction) doStop:(id)sender
{
	[self.wheel stopWheel];
}

*/

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
