//
//  MemoryGame.swift
//  Stanford_MemoryGame
//
//  Created by ahmed alfrash on 4/8/2020.
//

import Foundation

struct MemoryGame <CardContent> where CardContent: Equatable{
    private(set) var cards: [Card]
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get{
            cards.indices.filter {cards[$0].isFaceUp}.only
        }
        set{
            for index in cards.indices{
                // newValue is aspecial var only exiset in set
                cards[index].isFaceUp = index == newValue
                
            }
        }
    }
    
    mutating func choose(card: Card){
        // chosen card is not face up and have no match
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched{
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
                if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            }else{
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    
    
    //MARK:- initialize cards Array<Card>
    init(numberOfBairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for pairIndex in 0..<numberOfBairsOfCards{
            let content = cardContentFactory(pairIndex)
            
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false {
            didSet{  // proberty observrs
                if isFaceUp{
                    startUsingBonusTime()
                }else{
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var content: CardContent // T Generic
        
        
        // MARK:- Bonus Time
        
        // this could give matching bonus points
        // if th user matches the card
        // befor a certain amount of time passes during which the card is face up
        
        // can be zero which means " no bouns avilable " for this card
        
        var bonusTimeLimit: TimeInterval = 6
        
        // how long this card has ever been face up
        private var faceUpTime: TimeInterval{
            if let lastFaceUpDate = lastFaceUpDate {
               return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            }else{
               return pastFaceUpTime
            }
        }
        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        // the accumulated time this card has been face up in the past
        //(i.e not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        //how much time left befor the bouns opportunity runs out
        var bonusTimeRemaining: TimeInterval{
            max(0, bonusTimeLimit - faceUpTime)
        }
        // prcentage of bouns time remaining
        var bonusRemaining: Double{
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool{
            isMatched && bonusTimeRemaining > 0
        }
        
        // whether we are currently face up, unmatched ad have not yet used up the bonus window
        var isConsumingBonusTime: Bool{
            isFaceUp && isMatched && bonusTimeRemaining > 0
        }
        
        // called whene the card transition to face up state
        private mutating func startUsingBonusTime(){
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // called whene the card gose bace face down or gets matched
        private mutating func stopUsingBonusTime(){
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
    }
}












