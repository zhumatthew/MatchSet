//
//  SetCard.m
//  MatchSet
//
//  Created by Matt Zhu on 7/22/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

@synthesize symbol = _symbol;
@synthesize shading = _shading;
@synthesize color = _color;

// NSColor // NSForegroundColorAttributeName // Outside stroke, inside light shade
+ (NSArray *)validSymbols {
    return @[@"◼",@"●",@"▲"];
}

+ (NSArray *)validShadings {
    return @[@"S",@"H",@"O"];
}

+ (NSArray *)validColors {
    return @[@"R",@"G",@"B"];
}

+ (NSArray *)numberStrings {
    return @[@"?",@"1",@"2",@"3"];
}

+ (NSUInteger)maxNumber { return [self numberStrings].count-1; }

- (void)setSymbol:(NSString *)symbol {
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (void)setShading:(NSString *)shading {
    if ([[SetCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

- (void)setColor:(NSString *)color {
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (void)setNumber:(NSUInteger)number {
    if (number <= [SetCard maxNumber]) {
        _number = number;
    }
}

- (NSString *)symbol {
    return _symbol ? _symbol : @"?";
}

- (NSString *)shading {
    return _shading ? _shading : @"?";
}

- (NSString *)color {
    return _color ? _color : @"?";
}

- (NSString *)contents {
    NSArray *numberStrings = [SetCard numberStrings];
    return [NSString stringWithFormat:@"%@%@%@%@",numberStrings[self.number],self.symbol,self.shading,self.color];
}

- (int)match:(NSArray *)otherCards {
    int score = 0;
    if (otherCards.count == 2) {
        SetCard *cardOne = otherCards[0];
        SetCard *cardTwo = otherCards[1];
        if ((cardOne.number != cardTwo.number && cardOne.number != self.number && cardTwo.number != self.number) || (cardOne.number == self.number && cardTwo.number == self.number)) {
            if ([self matchFeatures:@[self.symbol,cardOne.symbol,cardTwo.symbol]] && [self matchFeatures:@[self.shading,cardOne.shading,cardTwo.shading]] && [self matchFeatures:@[self.color,cardOne.color,cardTwo.color]]) {
                score = 4;
            }
        }
    }
    return score;
}

- (BOOL)matchFeatures:(NSArray *)features {
    NSString *featureOne = features[0];
    NSString *featureTwo = features[1];
    NSString *featureThree = features[2];
    if (([featureOne isEqualToString:featureTwo] && [featureOne isEqualToString:featureThree]) || (![featureOne isEqualToString:featureTwo] && ![featureTwo isEqualToString:featureThree] && ![featureOne isEqualToString:featureThree])) {
        return YES;
    }
    return NO;
}

@end
