//
//  ViewController.m
//  TableViewAnimationTest
//
//  Created by Carly and Todd Crown on 5/31/13.
//  Copyright (c) 2013 Golf Contender. All rights reserved.
//


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

    UIView *cellUIView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cell.contentView.frame) - 37-10, 0, 37, 37)];
    cellUIView.tag = 1;
    
    
    
    UIImage *img = [UIImage imageNamed:@"circle.png"];
    CALayer *sublayer = [CALayer layer];
    sublayer.contents = (id)img.CGImage;
    sublayer.frame = CGRectMake(0, 0, 37, 37);

	cellUIView.transform =	CGAffineTransformTranslate(CGAffineTransformMakeScale(0.3, 0.3), -1000, 0);
	[UIView animateWithDuration:1.8f delay:CELL_ANIMATION_DELAY * indexPath.row options:0 animations:^{
		cellUIView.transform = CGAffineTransformIdentity;
	} completion:^(BOOL finished) {
		;
	}];
    

    [cellUIView.layer addSublayer:sublayer];
    
    [cell addSubview:cellUIView];


    return cell;
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
