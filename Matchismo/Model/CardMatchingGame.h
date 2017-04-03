//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Techno Software on 03/04/17.
//  Copyright © 2017 Techno Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Deck.h"

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly) NSInteger score;

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@end
