//
//  Cardify.swift
//  SwiftUIMemoryGame
//
//  Created by ahmed alfrash on 8/29/20.
//  Copyright © 2020 ahmed alfrash. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier{
    
    var rotation: Double
    
    init(isFaceUp: Bool){
        rotation = isFaceUp ? 0 : 180
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double{
        get {return rotation}
        set {rotation = newValue}
    }
    
    func body(content: Content) -> some View {
        ZStack{
            Group{
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: eadgeLineWidth)
                content
            }
            .opacity(isFaceUp ? 1 : 0)
                RoundedRectangle(cornerRadius: cornerRadius).fill()
                    .opacity(isFaceUp ? 0 : 1)
            
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let eadgeLineWidth: CGFloat = 3
}

extension View{
    func cardify(isFaceUp: Bool) -> some View{
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}











































