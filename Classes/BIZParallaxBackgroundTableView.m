//
//  BIZParallaxBackgroundTableView.m
//  BIZParallaxBackgroundTableView.m
//
//  Created by IgorBizi@mail.ru on 5/9/15.
//  Copyright (c) 2015 IgorBizi@mail.ru. All rights reserved.
//

#import "BIZParallaxBackgroundTableView.h"


#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@interface BIZParallaxBackgroundTableView () <UITableViewDelegate>
@property (nonatomic) CGFloat scrollViewOffsetY;
@property (strong, nonatomic) UIImageView *rootImageView;
@property (nonatomic, strong) UIImage *parallaxImage;
@end


@implementation BIZParallaxBackgroundTableView


- (void)addParallaxWithBackgroundWithImage:(UIImage *)image delegate:(id<UITableViewDelegate>)delegate
{
    _parallaxImage = image;
    _parallaxDelegate = delegate;
    [self setup];
}

- (void)setup
{
    self.backgroundView = [[UIView alloc] init];
    self.rootImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.rootImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.backgroundView addSubview:self.rootImageView];
    
    self.parallaxScrollSpeed = kParallaxScrollSpeedNormal;
    
    for (int i = 0; i < 2; i ++)
    {
        [self appendImageView];
    }
    
    self.delegate = self;
}

- (void)appendImageView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.parallaxImage];
    CGFloat x = 0;
    CGFloat y = -self.parallaxImage.size.height/2 + self.rootImageView.subviews.count * self.parallaxImage.size.height;
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.parallaxImage.size.height;
    imageView.frame = CGRectMake(x, y, w, h);
    [self.rootImageView addSubview:imageView];
}

- (void)removeParallaxBackground
{
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


#pragma mark - UIScrollViewDelegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.scrollViewOffsetY = scrollView.contentOffset.y;
    [self updateParallexOffset];
}

- (void)updateParallexOffset
{
    CGRect frame = self.rootImageView.frame;
    frame.origin.y = -self.scrollViewOffsetY / self.parallaxScrollSpeed;
    CGFloat lastImageViewOffsetY = (self.rootImageView.subviews.count - 1) * self.parallaxImage.size.height;
    BOOL needToAddImageView = (self.scrollViewOffsetY > lastImageViewOffsetY - kScreenHeight) ? YES : NO;
    if (needToAddImageView) {
        [self appendImageView];
    }
    
    [UIView animateWithDuration:0.075 animations:^{
        self.rootImageView.frame = frame;;
    }];
}


#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    cell.backgroundColor = self.overlayColor ? self.overlayColor : [UIColor clearColor];
    
    if ([self.parallaxDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.parallaxDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.parallaxDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.parallaxDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}



@end
