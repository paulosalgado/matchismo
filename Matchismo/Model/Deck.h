//
//  Deck.h
//  Matchismo
//
//  Created by Techno Software on 31/03/17.
//  Copyright © 2017 Techno Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card
          atTop:(BOOL)atTop;

- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
