//
//  Vector2D.m
//  Boids
//
//  Created by David Nolen on 11/3/09.
//  Copyright 2009 David Nolen. All rights reserved.
//  Changed by Sergey Dunets on 10/7/12
//  Copyright 2012 Sergey Dunets. All rights reserved.
//

#import "Vector2D.h"
#import <stdlib.h>
#import <math.h>

BOOL isZero(double a);
BOOL areEqual(double a, double b);

BOOL isZero(double a)
{
    return (fabs(a) < kEpsilon);
}

BOOL areEqual(double a, double b)
{
    return isZero(a-b);
}

@implementation Vector2D

#pragma mark -
#pragma mark new

+ (Vector2D*) withX:(double)x Y:(double)y
{
    return [[[Vector2D alloc] initWithX:x Y:y] autorelease];
}

+ (Vector2D*) newWithX:(double)x Y:(double)y
{
    return [[Vector2D alloc] initWithX:x Y:y];
}

#pragma mark -
#pragma mark Non-mutating Class methods

+ (Vector2D*) add:(Vector2D*)v1 to:(Vector2D*)v2
{
    return [[[v1 copy] autorelease] add:v2];
}

+ (Vector2D*) sub:(Vector2D*)v1 with:(Vector2D*)v2
{
    return [[[v1 copy] autorelease] sub:v2];
}

+ (Vector2D*) mult:(Vector2D*)v with:(double)scalar
{
    return [[[v copy] autorelease] mult:scalar];
}

+ (Vector2D*) div:(Vector2D*)v with:(double)scalar
{
    return [[[v copy] autorelease] div:scalar];
}

+ (double) dot:(Vector2D*)v1 with:(Vector2D*)v2
{
    return [v1 dot:v2];
}

+ (Vector2D*) zero
{
    return [Vector2D withX:0.0 Y:0.0];
}

+ (Vector2D*) randomInside:(CGRect)rect
{
    return [Vector2D withX:(rect.origin.x + (arc4random() % (int)rect.size.width)) Y:(rect.origin.y + (arc4random() % (int)rect.size.height))];
}

#pragma mark -
#pragma mark Useful Constants

static Vector2D* xAxis = nil;
static Vector2D* yAxis = nil;
static Vector2D* origin = nil;
static Vector2D* xy = nil;

+ (Vector2D*) xAxis
{
    if(nil == xAxis)
    {
        xAxis = [Vector2D newWithX:1.0 Y:0.0];
    }
    return xAxis;
}

+ (Vector2D*) yAxis
{
    if(nil == yAxis)
    {
        yAxis = [Vector2D newWithX:0.0 Y:1.0];
    }
    return yAxis;
}

+ (Vector2D*) origin
{
    if(nil == origin)
    {
        origin = [Vector2D newWithX:0.0 Y:0.0];
    }
    return origin;
}

+ (Vector2D*) xy
{
    if(nil == xy)
    {
        xy = [Vector2D newWithX:1.0 Y:1.0];
    }
    return xy;
}

#pragma mark -
#pragma mark Instance Methods

- (Vector2D*) init
{
    self = [self initWithX:0.0 Y:0.0];
    return self;
}

- (Vector2D*) initWithX:(double)nx Y:(double)ny
{
    self = [super init];
    if(nil != self)
    {
        x = nx;
        y = ny;
    }
    return self;
}

- (Vector2D*) copyWithZone:(NSZone *)zone
{
    return [[Vector2D alloc] initWithX:x Y:y];
}

- (NSString*) description
{
    return [NSString stringWithFormat:@"<%f, %f>", x, y];
}

- (NSString*) intDescription
{
    return [NSString stringWithFormat:@"<%.0f, %.0f>", x, y];
}

- (double) length
{
    return sqrt(x*x + y*y);
}

- (double) lengthSquared
{
    return (x*x + y*y);
}

- (BOOL) isEqual:(Vector2D*)other
{
    if (areEqual(x, other->x) && areEqual(y, other->y))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL) isZero
{
    return isZero(x*x + y*y);
}

- (Vector2D*) clean
{
    if(isZero(x)) x = 0.0;
    if(isZero(y)) y = 0.0;
    return self;
}

- (Vector2D*) zero
{
    x = 0.0;
    y = 0.0;
    return self;
}

- (Vector2D*) normalize
{
    double lengthsq = x*x + y*y;
    if (isZero(lengthsq))
    {
        x = 0.0;
        y = 0.0;
    }
    else
    {
        double factor = 1.0 / sqrt(lengthsq);
        x *= factor;
        y *= factor;
    }
    return self;
}

- (Vector2D*) limit:(double)limit
{
    return [[self normalize] mult:limit];
}

- (Vector2D*) add:(Vector2D*)other
{
    x += other->x;
    y += other->y;
    return self;
}

- (Vector2D*) sub:(Vector2D*)other
{
    x -= other->x;
    y -= other->y;
    return self;
}

- (Vector2D*) mult:(double)scalar
{
    x *= scalar;
    y *= scalar;
    return self;
}

- (Vector2D*) div:(double)scalar
{
    x /= scalar;
    y /= scalar;
    return self;
}

- (double) dot:(Vector2D*)other
{
    return (x*other->x + y*other->y);
}

- (Vector2D*) perp
{
    return [[Vector2D newWithX:-y Y:x] autorelease];
}

- (double) perpDot:(Vector2D*)other
{
    return (x*other->y - y*other->x);
}

- (Vector2D *) intValues
{
    return [Vector2D withX:(NSInteger)x Y:(NSInteger)y];
}

@end
