//
//  GameView.swift
//  MemoryGame
//
//  Created by ahmed alfrash on 8/17/20.
//  Copyright © 2020 ahmed alfrash. All rights reserved.
//

import SwiftUI

struct GameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture{
                    self.viewModel.choose(card: card)
                }
            .padding()
            }
        
        .padding()
        .foregroundColor(Color.orange)
    }
}



struct CardView: View {
    
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    
    func body(for size: CGSize) -> some View{
        ZStack {
            if card.isFaceUp{
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: eadgeLineWidth)
                Text(card.content)
            }else{
                if !card.isMatched{
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
                
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK:- Drawing Constance
    let cornerRadius: CGFloat = 10.0
    let eadgeLineWidth: CGFloat = 3
    func fontSize(for size: CGSize) -> CGFloat{
        min(size.width, size.height) * 0.75
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: EmojiMemoryGame())
    }
}

