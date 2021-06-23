//
//  MCDashLineView.m
//  TestCoreData
//
//  Created by kequ on 2021/6/23.
//

#import "MCDashLineView.h"

@implementation MCDashLineView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        [shapeLayer setBounds:self.bounds];
        [shapeLayer setPosition:CGPointMake(frame.size.width/2, frame.size.height/2)];
        [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
        [shapeLayer setStrokeColor:[UIColor redColor].CGColor];
        [shapeLayer setLineWidth:1.0f];
        [shapeLayer setLineJoin:kCALineJoinRound];
        [shapeLayer setLineDashPattern:
         [NSArray arrayWithObjects:[NSNumber numberWithInt:4],
          [NSNumber numberWithInt:3],nil]];
        
        // Setup the path
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 0,frame.size.height/2);
        CGPathAddLineToPoint(path, NULL, frame.size.width, frame.size.height/2);
        
        [shapeLayer setPath:path];
        CGPathRelease(path);
        
        [self.layer addSublayer:shapeLayer];
    }
    
    return self;
}

@end
