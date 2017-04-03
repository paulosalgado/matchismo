//
//  PlayingCard.m
//  Matchismo
//
//  Created by Techno Software on 31/03/17.
//  Copyright © 2017 Techno Software. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit; // because we provide setter AND getter

- (int)match:(NSArray *)otherCards {
    
    int score = 0;
    int cardsCount = (int) [otherCards count];
    
    if (cardsCount) {
        
        for (int i = 0; i < cardsCount; i++) {
            
            id card = [otherCards objectAtIndex:i];
            
            if ([card isKindOfClass:[PlayingCard class]]) {
                
                PlayingCard *otherCard = (PlayingCard *)card;
                
                if ([self.suit isEqualToString:otherCard.suit]) {
                    score += 1;
                } else if (self.rank == otherCard.rank) {
                    score += 4;
                }
                
            }
        }
        
    }
    
    return score;
}

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits {
    return @[@"♥︎", @"♦︎", @"♠︎", @"♣︎"];
}

- (void)setSuit:(NSString *)suit {
    
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
    
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank {
    
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
    
}

@end
