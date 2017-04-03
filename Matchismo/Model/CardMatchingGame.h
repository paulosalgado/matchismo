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

#define NOT_SELECTED_MATCH_MODE -1
#define TWO_CARD_MATCH_MODE 0
#define THREE_CARD_MATCH_MODE 1

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSString *status;
@property (nonatomic) NSUInteger gameMode;

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@end
