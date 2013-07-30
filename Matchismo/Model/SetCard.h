//
//  SetCard.h
//  MatchSet
//
//  Created by Matt Zhu on 7/22/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *color;
@property (nonatomic) NSUInteger number;

+ (NSArray *)validSymbols;
+ (NSUInteger)maxNumber;
+ (NSArray *)validShadings;
+ (NSArray *)validColors;

@end
