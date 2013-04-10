//
//  DACircularProgressView.m
//  DACircularProgress
//
//  Created by Daniel Amitay on 2/6/12.
//  Copyright (c) 2012 Daniel Amitay. All rights reserved.
//

#import "DACircularProgressView.h"

#define DEGREES_2_RADIANS(x) (0.0174532925 * (x))

@implementation DACircularProgressView

@synthesize trackTintColor = _trackTintColor;
@synthesize progressTintColor =_progressTintColor;
@synthesize progress = _progress;
@synthesize statusImgView = _statusImgView;
@synthesize isPlay = _isPlay;
@synthesize preProgress = _preProgress;

- (id)init
{
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
//        [self setBackgroundColor:[UIColor blackColor]];
        
        _statusImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"progressPlay.png"]];
        
        _isPlay = NO;
        
        CGFloat width = self.frame.size.width / 2;
        CGFloat height = self.frame.size.height / 2;
        [_statusImgView setFrame:CGRectMake(self.frame.size.width / 4, self.frame.size.height / 4, width, height)];
        [self addSubview:_statusImgView];
        [_statusImgView release];
    }
    return self;
}

- (void)setStatus {
    if (_isPlay) {
        [_statusImgView setImage:[UIImage imageNamed:@"progressPlay.png"]];
        _isPlay = NO;
    } else {
        [_statusImgView setImage:[UIImage imageNamed:@"progressPause.png"]];
        _isPlay = YES;
    }
    
}

- (void)setStatusToPlay {
    [_statusImgView setImage:[UIImage imageNamed:@"progressPlay.png"]];
    _isPlay = NO;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{    
    CGPoint centerPoint = CGPointMake(rect.size.height / 2, rect.size.width / 2);
    CGFloat radius = MIN(rect.size.height, rect.size.width) / 2;
    
    CGFloat pathWidth = radius * 0.3f;
    
    CGFloat radians = DEGREES_2_RADIANS((self.progress*359.9)-90);
    CGFloat xOffset = radius*(1 + 0.85*cosf(radians));
    CGFloat yOffset = radius*(1 + 0.85*sinf(radians));
    CGPoint endPoint = CGPointMake(xOffset, yOffset);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self.trackTintColor setFill];
    CGMutablePathRef trackPath = CGPathCreateMutable();
    CGPathMoveToPoint(trackPath, NULL, centerPoint.x, centerPoint.y);
    CGPathAddArc(trackPath, NULL, centerPoint.x, centerPoint.y, radius, DEGREES_2_RADIANS(270), DEGREES_2_RADIANS(-90), NO);
    CGPathCloseSubpath(trackPath);
    CGContextAddPath(context, trackPath);
    CGContextFillPath(context);
    CGPathRelease(trackPath);
    
    
//    [self.progressTintColor setFill];
    _progressTintColor = [UIColor colorWithRed:0 green:188.0/255 blue:250.0/255 alpha:1];
    [_progressTintColor setFill];
    CGMutablePathRef progressPath = CGPathCreateMutable();
    CGPathMoveToPoint(progressPath, NULL, centerPoint.x, centerPoint.y);
    CGPathAddArc(progressPath, NULL, centerPoint.x, centerPoint.y, radius, DEGREES_2_RADIANS(270), radians, NO);
    CGPathCloseSubpath(progressPath);
    CGContextAddPath(context, progressPath);
    CGContextFillPath(context);
    CGPathRelease(progressPath);
    
    CGContextAddEllipseInRect(context, CGRectMake(centerPoint.x - pathWidth/2, 0, pathWidth, pathWidth));
    CGContextFillPath(context);
    
    CGContextAddEllipseInRect(context, CGRectMake(endPoint.x - pathWidth/2, endPoint.y - pathWidth/2, pathWidth, pathWidth));
    CGContextFillPath(context);
    
    CGContextSetBlendMode(context, kCGBlendModeClear);;
    CGFloat innerRadius = radius * 0.7;
	CGPoint newCenterPoint = CGPointMake(centerPoint.x - innerRadius, centerPoint.y - innerRadius);    
	CGContextAddEllipseInRect(context, CGRectMake(newCenterPoint.x, newCenterPoint.y, innerRadius*2, innerRadius*2));
	CGContextFillPath(context);
}

#pragma mark - Property Methods

- (UIColor *)trackTintColor
{
    if (!_trackTintColor)
    {
//        _trackTintColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.3f];
        _trackTintColor = [UIColor lightGrayColor];
    }
    return _trackTintColor;
}

- (UIColor *)progressTintColor
{
    if (!_progressTintColor)
    {
        _progressTintColor = [UIColor colorWithRed:12.0/255 green:139.0/255 blue:232.0/255 alpha:1];
    }
    return _progressTintColor;
}

- (void)setProgress:(float)progress
{
    _progress = progress;
    if (progress > 0.99) {
        [self setHidden:YES];
        [self performSelector:@selector(caca) withObject:self afterDelay:0.5];
    }else if (progress > 0.0) {
        _preProgress = progress;
        [self performSelector:@selector(haha) withObject:self afterDelay:1.0];
    }
    
    [self setNeedsDisplay];
}

- (void)caca {
    UITableView *myView = (UITableView *)(self.superview.superview);
    [myView reloadData];
}

- (void)haha {
    UITableView *myView = (UITableView *)(self.superview.superview);
    [myView reloadData];
}

@end
