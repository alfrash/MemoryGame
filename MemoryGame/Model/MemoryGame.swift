//
//  MemoryGame.swift
//  Stanford_MemoryGame
//
//  Created by ahmed alfrash on 4/8/2020.
//

import Foundation

struct MemoryGame <CardContent> where CardContent: Equatable{
    var cards: [Card]
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
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
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent // T Generic
    }
}
