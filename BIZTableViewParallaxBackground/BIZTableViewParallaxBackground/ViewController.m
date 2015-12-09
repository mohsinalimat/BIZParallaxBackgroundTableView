//
//  ViewController.m
//  BIZTableViewParallaxBackground
//
//  Created by IgorBizi@mail.ru on 12/9/15.
//  Copyright © 2015 IgorBizi@mail.ru. All rights reserved.
//

#import "ViewController.h"
#import "BIZTableViewParallaxBackground.h"


@interface ViewController () <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet BIZTableViewParallaxBackground *tableView;
@property (nonatomic) NSMutableArray *dataSource;

@end


@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.dataSource = [NSMutableArray array];
    for (NSInteger i = 0; i < 300; i++)
    {
        [self.dataSource addObject:[NSString stringWithFormat:@"### %ld ", (long)i]];
    }
    
    [self.tableView setParallaxBackgroundImage:[UIImage imageNamed:@"image.jpg"] delegate:self];
}


#pragma mark - UITableViewDelegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

@end
