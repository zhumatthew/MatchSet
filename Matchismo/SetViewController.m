//
//  SetViewController.m
//  MatchSet
//
//  Created by Matt Zhu on 7/24/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "SetViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation SetViewController

@synthesize deck = _deck;

- (Deck *)deck {
    if (!_deck) _deck = [[SetCardDeck alloc] init];
    return _deck;
}

- (void)updateUI {
    [super updateUI];
    for (UIButton *cardButton in self.cardButtons) {
        UIColor *foregroundColor;
        UIColor *strokeColor;
        
        SetCard *card = (SetCard *)[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        NSString *string = [[NSString alloc] init];
        for (int i = 0; i < card.number; i++) {
            string = [NSString stringWithFormat:@"%@%@", string, card.symbol];
        }
        if ([card.color isEqualToString:@"R"]) {
            foregroundColor = [UIColor redColor];
        } else if ([card.color isEqualToString:@"G"]) {
            foregroundColor = [UIColor greenColor];
        } else if ([card.color isEqualToString:@"B"]) {
            foregroundColor = [UIColor blueColor];
        }
        
        strokeColor = [foregroundColor copy];
        
        if ([card.shading isEqualToString:@"S"]) {
            foregroundColor = [foregroundColor colorWithAlphaComponent:1];
        } else if ([card.shading isEqualToString:@"H"]) {
            foregroundColor = [foregroundColor colorWithAlphaComponent:0.3];
        } else if ([card.shading isEqualToString:@"O"]) {
            foregroundColor = [foregroundColor colorWithAlphaComponent:0];
        }
        NSAttributedString *mat = [[NSAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName:foregroundColor,NSStrokeWidthAttributeName:@-5,NSStrokeColorAttributeName:strokeColor}];
        [cardButton setAttributedTitle:mat forState:UIControlStateNormal];
        CGFloat red;
        CGFloat green;
        CGFloat blue;
        CGFloat alpha;
        [foregroundColor getRed:&red green:&green blue:&blue alpha:&alpha];
        NSLog(@"red:%f green:%f blue:%f alpha:%f index:%d",red,green,blue,alpha,[self.cardButtons indexOfObject:cardButton]);
        [strokeColor getRed:&red green:&green blue:&blue alpha:&alpha];
        NSLog(@"red:%f green:%f blue:%f alpha:%f ",red,green,blue,alpha);
        NSLog(@"%@",[mat string]);
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        
        if (card.isFaceUp) {
            [cardButton setBackgroundColor:[UIColor lightGrayColor]];
        } else {
            [cardButton setBackgroundColor:[UIColor whiteColor]];
        }
    }
//    UIImage *cardbackImage = [UIImage imageNamed:@"cardback.png"];
//    for (UIButton *cardButton in self.cardButtons) {
//        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
//        [cardButton setTitle:card.contents forState:UIControlStateSelected];
//        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
//        cardButton.selected = card.isFaceUp;
//        cardButton.enabled = !card.isUnplayable;
//        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
//        
//        if (card.isFaceUp) {
//            [cardButton setImage:nil forState:UIControlStateNormal];
//        } else {
//            [cardButton setImage:cardbackImage forState:UIControlStateNormal];
//        }
//    }
}

@end
