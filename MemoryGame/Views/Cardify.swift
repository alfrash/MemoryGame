//
//  Cardify.swift
//  SwiftUIMemoryGame
//
//  Created by ahmed alfrash on 8/29/20.
//  Copyright © 2020 ahmed alfrash. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier{
    
    var isFaceUp: Bool
    func body(content: Content) -> some View {
        ZStack{
            if isFaceUp{
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: eadgeLineWidth)
                content
            }else{
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let eadgeLineWidth: CGFloat = 3
}

extension View{
    func cardify(isFaceUp: Bool) -> some View{
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}











































