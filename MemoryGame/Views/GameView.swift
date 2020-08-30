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
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View{
        if card.isFaceUp || !card.isMatched{
            ZStack {
                       Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(110 - 90),clockwise: true)
                           .padding(5)
                           .opacity(0.4)
                       Text(card.content)
                       .font(Font.system(size: fontSize(for: size)))
                   }
                   .cardify(isFaceUp: card.isFaceUp)
        }
       
    }
    
    // MARK:- Drawing Constance
   
    private func fontSize(for size: CGSize) -> CGFloat{
        min(size.width, size.height) * 0.7
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return GameView(viewModel: game)
    }
}







































