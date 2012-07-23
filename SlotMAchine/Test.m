//
//  Test.m
//  SlotMAchine
//
//  Created by RAVI DAS on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Test.h"
#import "PPSpinWheelView.h"

@implementation Test

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    images1 = [[NSMutableArray alloc]initWithObjects:@"0.png",@"1.png",@"2.png",@"3.png",@"4.png",@"5.png",@"6.png",@"7.png",@"8.png",@"9.png", nil];
    images2 = [[NSMutableArray alloc]initWithObjects:@"apple.png",@"berry.png",@"bar.png",@"grap.png",@"seven.png", nil];
    pp = [[PPSpinWheelView alloc] initWithFrame:CGRectMake(47, 101, 226,102)];
    [self.view addSubview:pp];
    
    pp.backgroundColor = [UIColor clearColor];
    pp.delegate = self;
    pp.dataSource = self;
    [pp reloadSpinningWheel];
    
    
}

-(NSInteger) noOfComponentsInPPSpinWheel:(PPSpinWheelView*)ppSpinWheelView
{
    return 3;
}


-(CGFloat)margineForComponentsInPPSpinWheel:(PPSpinWheelView *)ppSpinWheelView
{
    return 10;
}

-(NSInteger)noOfViewShowOnComponentsInPPSpinWheel:(PPSpinWheelView *)ppSpinWheelView
{
    return 3;
}

-(NSTimeInterval)PPSpinWheelView:(PPSpinWheelView *)ppSpinWheelView spinDurationForComponent:(NSInteger)section
{
    if(section == 0)
        return 30;
    else 
        return 20;
}

-(NSInteger)PPSpinWheelView:(PPSpinWheelView*)ppSpinWheelView noOfRowsInComponent:(NSInteger)section
{
//    if(section == 0)
//        return [images1 count];
//    else 
       return [images1 count];
    
    return 0;
}

-(UIView*)PPSpinWheelView:(PPSpinWheelView*)ppSpinWheelView viewForRowAtIndexPath:(NSIndexPath*)indexPath{
    
    UIImageView *imgView;
//    if(indexPath.section == 0)
//        imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[images1 objectAtIndex:indexPath.row]]];
//    else
        imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[images1 objectAtIndex:indexPath.row]]];
    if(imgView)
    {
        CGRect rect = imgView.frame;
        rect.size = CGSizeMake(imgView.frame.size.width, 10);
        imgView.frame = rect;
    }
    return imgView;
}

-(CGFloat)PPSpinWheelView:(PPSpinWheelView*)ppSpinWheelView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 10;
}


- (IBAction) doSpin:(id)sender
{
	//[pp spinComponentAtIndex:0];
    //[pp spinComponentAtIndex:1];

    [pp spinAllComponents];
}

-(void)spinEndedWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"ended component -> %d At %d",indexPath.section,indexPath.row);
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
