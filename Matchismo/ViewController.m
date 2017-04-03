//
//  ViewController.m
//  Matchismo
//
//  Created by Techno Software on 31/03/17.
//  Copyright © 2017 Techno Software. All rights reserved.
//

#import "ViewController.h"

#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController()

@property (nonatomic, strong) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;
@property (nonatomic) NSInteger lastIndex;

@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeSelector;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *gameStatus;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation ViewController

- (Deck *)deck {
    if (!_deck) _deck = [self createDeck];
    return _deck;
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (CardMatchingGame *)game {
    
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    
    return _game;
}

- (IBAction)startNewGame:(id)sender {
    
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                              usingDeck:[self createDeck]];
    
    [self updateUI];
    self.matchModeSelector.enabled = true;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    if (self.matchModeSelector.enabled) {
        self.game.gameMode = [self.matchModeSelector selectedSegmentIndex];
        self.matchModeSelector.enabled = false;
    }
    
    int cardIndex = (int) [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    
    [self updateUI];
}

- (void)updateUI {
    
    for (UIButton *cardButton in self.cardButtons) {
        
        int cardIndex = (int) [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        
        cardButton.enabled = !card.isMatched;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", (int) self.game.score];
    self.gameStatus.text = self.game.status;
}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardFront": @"cardBack"];
}

@end
