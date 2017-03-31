//
//  ViewController.m
//  Matchismo
//
//  Created by Techno Software on 31/03/17.
//  Copyright © 2017 Techno Software. All rights reserved.
//

#import "ViewController.h"

#import "PlayingCardDeck.h"

@interface ViewController()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic, strong) Deck *deck;

@end

@implementation ViewController

- (Deck *)deck {
    if (!_deck) _deck = [self createDeck];
    return _deck;
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    if ([sender.currentTitle length]) {
        
        [sender setBackgroundImage:[UIImage imageNamed:@"cardBack"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
        
        self.flipCount++;
        
    } else {
        
        Card *card = [self.deck drawRandomCard];
        
        if (card) {
            
            [sender setBackgroundImage:[UIImage imageNamed:@"cardFront"]
                              forState:UIControlStateNormal];
            [sender setTitle:card.contents forState:UIControlStateNormal];
            
            self.flipCount++;
        }
        
    }
    
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flipsCount = %d", self.flipCount);
}

@end
