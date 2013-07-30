//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Matt Zhu on 7/2/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"


@interface CardGameViewController ()

@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                          usingDeck:self.deck];
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI {
  
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    if (self.game.flipResults) {
        self.resultsLabel.text = [NSString stringWithFormat:@"%@", self.game.flipResults];
    }
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flips updated to %d", self.flipCount);
}

- (IBAction)deal:(id)sender {
    self.game = nil;
    self.flipCount = 0;
    [self updateUI];
}

- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    NSLog(@"index:%d",[self.cardButtons indexOfObject:sender]);
    NSLog(@"index:%d",[self.cardButtons indexOfObject:sender]);
    NSLog(@"index:%d",[self.cardButtons indexOfObject:sender]);
    NSLog(@"index:%d",[self.cardButtons indexOfObject:sender]);
    NSLog(@"index:%d",[self.cardButtons indexOfObject:sender]);
    [self updateUI];
}


@end
