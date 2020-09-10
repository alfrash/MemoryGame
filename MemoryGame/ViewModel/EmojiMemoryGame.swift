//
//  EmojiMemoryGame.swift
//  Stanford_MemoryGame
//
//  Created by ahmed alfrash on 4/8/2020.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    // private(set): view can see model (MemoryGame<String>) but cannot edit or access it only viewModel can
    // private: view cannot see model (MemoryGame<String>) and cannot edit or access it only viewModel can
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["🐙", "🐳", "🐠"]
        return MemoryGame(numberOfBairsOfCards: emojis.count) { pairIndex in
            emojis[pairIndex]
        }
    }
        
    
    
    //MARK:- Access to the Model
    var cards: Array<MemoryGame<String>.Card>{
        model.cards // access cards array from model
    }
    
    // MARK:- User Intent(s) view change viewModel then viewModel change model
    
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
    
    func resetGame(){
        model = EmojiMemoryGame.createMemoryGame()
    }
}

//func createCardContent(pairIndex: Int) -> String{
//    "🐙"
//}












