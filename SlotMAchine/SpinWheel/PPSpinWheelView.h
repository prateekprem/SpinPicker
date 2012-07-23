//
//  PPSpinWheelView.h
//  SlotMAchine
//
//  Created by RAVI DAS on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WheelSpinner.h"




@class PPSpinWheelView;
@protocol PPSpinWheelDelegate <NSObject>

-(void)spinEndedWithIndexPath:(NSIndexPath*)indexPath;

-(WheelSpinner*)componentAtIndex:(NSInteger)index;

-(CGFloat)margineForComponentsInPPSpinWheel:(PPSpinWheelView*)ppSpinWheelView; 

-(CGFloat)PPSpinWheelView:(PPSpinWheelView*)ppSpinWheelView heightForRowAtIndexPath:(NSIndexPath*)indexPath;

-(NSTimeInterval)PPSpinWheelView:(PPSpinWheelView*)ppSpinWheelView spinDurationForComponent:(NSInteger)section;

-(NSInteger)noOfViewShowOnComponentsInPPSpinWheel:(PPSpinWheelView*)ppSpinWheelView;

@required

-(UIView*)PPSpinWheelView:(PPSpinWheelView*)ppSpinWheelView viewForRowAtIndexPath:(NSIndexPath*)indexPath;

@end

@protocol PPSpinWheelDataSource <NSObject>

@required

-(NSInteger) noOfComponentsInPPSpinWheel:(PPSpinWheelView*)ppSpinWheelView;

-(NSInteger)PPSpinWheelView:(PPSpinWheelView*)ppSpinWheelView noOfRowsInComponent:(NSInteger)section;



@end

@interface PPSpinWheelView : UIView<WheelSpinnerDelegate>
{
    id<PPSpinWheelDelegate> _delegate;
    id<PPSpinWheelDataSource> _dataSource;
    
    NSMutableArray *components;
  
}

@property (nonatomic, retain) IBOutlet id<PPSpinWheelDelegate> delegate;
@property (nonatomic, retain) IBOutlet id<PPSpinWheelDataSource> dataSource;


//- (NSInteger)numberOfComponents;
//- (NSInteger)numberOfRowsInInComponent:(NSInteger)section;

-(void)reloadSpinningWheel;
-(void)spinComponentAtIndex:(NSInteger)index;
-(void)spinAllComponents;
@end


// This category provides convenience methods to make it easier to use an NSIndexPath to represent a section and row


