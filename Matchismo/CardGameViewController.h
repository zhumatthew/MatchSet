//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Matt Zhu on 7/2/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

@property (nonatomic) Deck* deck;
@property (nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

- (void)updateUI;

@end
