//
//  ViewController.m
//  TableViewAnimationTest
//
//  Created by Carly and Todd Crown on 5/31/13.
//  Copyright (c) 2013 Golf Contender. All rights reserved.
//


#warning resizing works when the animations are added in cellforrow, but wonky shit happens when you add the animations in  viewdidappear


#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewController ()

@end

@implementation ViewController
int const CELL_VIEW_TAG = 1;
float const CELL_ANIMATION_DELAY = 0.05f;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
}

-(void)viewDidAppear:(BOOL)animated
{
#warning remove comment and add comment to if statement in cellforrow
    //animate cells that are visible
    int count = 0;
    for(UITableViewCell *cell in self.menuTableView.visibleCells)
    {
        UIView *subView = [cell viewWithTag:CELL_VIEW_TAG];
        CALayer *sublayer = subView.layer;
        [self addAnimationsToLayer:sublayer count:count];
        count++;
    }
     
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL shouldDoTableAnimations = NO;
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        shouldDoTableAnimations = YES;
    }
    
    UIView *tmpV = [cell viewWithTag:1];
    if(tmpV != nil)
       [tmpV removeFromSuperview];

    UIView *cellUIView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
    cellUIView.tag = 1;
    
    
    
    UIImage *img = [UIImage imageNamed:@"circle.png"];
    CALayer *sublayer = [CALayer layer];
    sublayer.contents = (id)img.CGImage;
    sublayer.frame = CGRectMake(0, 0, 37, 37);
    sublayer.position = CGPointMake(cell.frame.size.width - (sublayer.frame.size.width/2) - 10, (sublayer.frame.size.width/2) + 10);
    
    
    
    if(shouldDoTableAnimations)
    {
#warning remove comment and comment out viewdidappear
        //[self addAnimationsToLayer:sublayer count:indexPath.row];
    }
    
    [cellUIView.layer addSublayer:sublayer];
    //[cell.layer addSublayer:sublayer];
    
    [cell addSubview:cellUIView];
    
    //cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row +1];
    
    // Configure the cell...
    //NSLog(@"%f", cell.frame.size.width);

    return cell;
}

-(void) addAnimationsToLayer:(CALayer *)sublayer count:(int)count
{
    sublayer.opacity = 1.0f;
    float delay = CELL_ANIMATION_DELAY * (count);
    
    //[sublayer addAnimation:[self opacityAnimation:0.0f toValue:1.0f delay:delay] forKey:@"opacityAnimation"];
    //[sublayer addAnimation:[self positionAnimation:CGPointMake(0, 0) endPoint:sublayer.position delay:delay] forKey:@"positionAnimation"];
    [sublayer addAnimation:[self frameAnimation:CGRectMake(0, 0, 0, 0) endFrame:sublayer.frame delay:delay] forKey:@"frameAnimation"];
}

-(CABasicAnimation *)opacityAnimation:(float)fromValue toValue:(float)toValue delay:(float)delay
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anim.fromValue = [NSNumber numberWithFloat:fromValue];
    anim.toValue = [NSNumber numberWithFloat:toValue];
    anim.removedOnCompletion = NO;
    [anim setFillMode:kCAFillModeForwards];
    anim.duration = 2.6f;
    anim.delegate = self;
    anim.beginTime = CACurrentMediaTime() + delay;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    return anim;
}

- (CABasicAnimation *)positionAnimation:(CGPoint)startPoint
                               endPoint:(CGPoint)endPoint
                                  delay:(float)delay
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
    anim.fromValue = [NSValue valueWithCGPoint:startPoint];
    anim.toValue = [NSValue valueWithCGPoint:endPoint];
    anim.removedOnCompletion = NO;
    [anim setFillMode:kCAFillModeForwards];
    [anim setDuration:0.8f];
    [anim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    anim.repeatCount = 1;
    anim.beginTime = CACurrentMediaTime() + delay;
    anim.delegate = self;
    return anim;
}

- (CABasicAnimation *)frameAnimation:(CGRect)startFrame
                               endFrame:(CGRect)endFrame
                                  delay:(float)delay
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"bounds"];
    anim.fromValue = [NSValue valueWithCGRect:startFrame];
    anim.toValue = [NSValue valueWithCGRect:endFrame];
    anim.removedOnCompletion = NO;
    [anim setFillMode:kCAFillModeForwards];
    [anim setDuration:1.8f];
    [anim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    anim.repeatCount = 1;
    anim.beginTime = CACurrentMediaTime() + delay;
    anim.delegate = self;
    return anim;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}
@end
