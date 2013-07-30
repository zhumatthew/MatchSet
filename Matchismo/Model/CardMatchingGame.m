//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Matt Zhu on 7/5/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCard.h"

@interface CardMatchingGame ()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (nonatomic) NSString *flipResults;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}


- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    if (self) {
        _flipResults = @"";
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < self.cards.count) ? self.cards[index] : nil;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void)flipCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            self.flipResults = [NSString stringWithFormat:@"Flipped up %@",card.contents];
            if ([card isMemberOfClass:[PlayingCard class]]) {
                for (Card *otherCard in self.cards) {
                    if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                        int matchScore = [card match:@[otherCard]];
                        int increment;
                        if (matchScore) {
                            otherCard.unplayable = YES;
                            card.unplayable = YES;
                            increment = matchScore * MATCH_BONUS;
                            self.score += increment;
                            self.flipResults = [NSString stringWithFormat:@"Matched %@ & %@ for %d points", card.contents, otherCard.contents, increment];
                        } else {
                            otherCard.faceUp = NO;
                            increment = MISMATCH_PENALTY;
                            self.score -= increment;
                            self.flipResults = [NSString stringWithFormat:@"%@ and %@ don't match! %d point penalty!", card.contents, otherCard.contents, increment];
                        }
                    }
                }
            } else {
                NSMutableArray *otherCards = [[NSMutableArray
                                               alloc] init];
                for (Card *otherCard in self.cards) {
                    if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                        [otherCards addObject:otherCard];
                    }
                }
                if ([otherCards count] == 2) {
                    int matchScore = [card match:otherCards];
                    int increment;
                    if (matchScore) {
                        [otherCards[0] setUnplayable:YES];
                        [otherCards[1] setUnplayable:YES];
                        card.unplayable = YES;
                        increment = matchScore * MATCH_BONUS;
                        self.score += increment;
                        self.flipResults = [NSString stringWithFormat:@"Matched %@ & %@ & %@ for %d points", card.contents, [otherCards[0] contents], [otherCards[1] contents], increment];
                    } else {
                        [otherCards[0] setFaceUp:NO];
                        [otherCards[1] setFaceUp:NO];
                        increment = MISMATCH_PENALTY;
                        self.score -= increment;
                        self.flipResults = [NSString stringWithFormat:@"%@ & %@ & %@ don't match! %d point penalty!", card.contents, [otherCards[0] contents], [otherCards[1] contents], increment];
                    }
                }

            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}

@end
