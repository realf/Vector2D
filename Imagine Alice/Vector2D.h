//
//  Vector2D.m
//  Boids
//
//  Created by David Nolen on 11/3/09.
//  Copyright 2009 David Nolen. All rights reserved.
//  Changed by Sergey Dunets on 10/7/12
//  Copyright 2012 Sergey Dunets. All rights reserved.
//

#define kEpsilon    1.0e-6
#define kPI         3.1415926535897932384626433832795
#define kHalfPI     1.5707963267948966192313216916398
#define kTwoPI      2.0*kPI

@interface Vector2D : NSObject <NSCopying>
{
@public
    double x;
    double y;
}

// Class Methods

+ (Vector2D*) withX:(double)x Y:(double)y;
+ (Vector2D*) newWithX:(double)x Y:(double)y;

+ (Vector2D*) add:(Vector2D*)v1 to:(Vector2D*)v2;
+ (Vector2D*) sub:(Vector2D*)v1 with:(Vector2D*)v2;
+ (Vector2D*) mult:(Vector2D*)v with:(double)scalar;
+ (Vector2D*) div:(Vector2D*)v with:(double)scalar;
+ (double) dot:(Vector2D*)v1 with:(Vector2D*)v2;

+ (Vector2D*) xAxis;
+ (Vector2D*) yAxis;
+ (Vector2D*) origin;
+ (Vector2D*) xy;
+ (Vector2D*) zero;
+ (Vector2D*) randomInside:(CGRect)rect;

// Instance Methods

- (Vector2D*) initWithX:(double)x Y:(double)y;
- (Vector2D*) copyWithZone:(NSZone *)zone;

- (NSString*) description;

- (double) length;
- (double) lengthSquared;

- (BOOL) isEqual:(Vector2D*)other;
- (BOOL) isZero;

- (Vector2D*) clean;
- (Vector2D*) zero;
- (Vector2D*) normalize;
- (Vector2D*) limit:(double)limit;

- (Vector2D*) add:(Vector2D*)other;
- (Vector2D*) sub:(Vector2D*)other;
- (Vector2D*) mult:(double)scalar;
- (Vector2D*) div:(double)scalar;

- (double) dot:(Vector2D*)other;
- (Vector2D*) perp;
- (double) perpDot:(Vector2D*)other;

@end
