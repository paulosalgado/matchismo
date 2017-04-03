//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Techno Software on 03/04/17.
//  Copyright © 2017 Techno Software. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, readwrite) NSString *status;

@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

@synthesize gameMode = _gameMode;

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)setGameMode:(NSUInteger)gameMode {
    
    if (gameMode == TWO_CARD_MATCH_MODE ||
        gameMode == THREE_CARD_MATCH_MODE) {
        
        _gameMode = gameMode;
    }
    
}

- (instancetype)init {
    return nil;
}

- (instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *)deck {
    
    self = [super init];
    
    if (self) {
        
        for (int i = 0; i < count; i++) {
            
            Card *card = [deck drawRandomCard];
            
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
            
        }
        
        self.gameMode = NOT_SELECTED_MATCH_MODE;
    }
    
    return self;
}

- (void)chooseCardAtIndex:(NSUInteger)index {
    
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        
        if (card.isChosen) {
            
            card.chosen = NO;
            
            _status = @"";
            
        } else {
            // match against another card
            
            _status = card.contents;
            
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    
                    int matchScore = [card match:@[otherCard]];
                    
                    if (matchScore) {
                        
                        int roundScore = matchScore * MATCH_BONUS;
                        self.score += roundScore;
                        card.matched = YES;
                        otherCard.matched = YES;
                        
                        _status = [NSString stringWithFormat:@"Matched %@ %@ for %d points.", card.contents, otherCard.contents, roundScore];
                        
                    } else {
                        
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                        
                        _status = [NSString stringWithFormat:@"%@ %@ don't match! %d point penalty!", card.contents, otherCard.contents, MISMATCH_PENALTY];
                    }
                    
                    break;
                }
            }
            
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
        
    }
    
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
