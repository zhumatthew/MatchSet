//
//  MatchViewController.m
//  MatchSet
//
//  Created by Matt Zhu on 7/24/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "MatchViewController.h"
#import "PlayingCardDeck.h"

@interface MatchViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation MatchViewController

@synthesize deck = _deck;

- (Deck *)deck {
    if (!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}

- (void)updateUI {
    [super updateUI];
    UIImage *cardbackImage = [UIImage imageNamed:@"cardback.png"];
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        
        if (card.isFaceUp) {
            [cardButton setImage:nil forState:UIControlStateNormal];
        } else {
            [cardButton setImage:cardbackImage forState:UIControlStateNormal];
        }
    }
}


@end
