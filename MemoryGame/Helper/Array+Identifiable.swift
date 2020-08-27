//
//  Array+Identifiable.swift
//  SwiftUIMemoryGame
//
//  Created by ahmed alfrash on 8/25/20.
//  Copyright © 2020 ahmed alfrash. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable{
    func firstIndex(matching: Element) -> Int?{
           for index in 0..<self.count{
               if self[index].id == matching.id{
                   return index
               }
           }
           return nil 
       }
}
