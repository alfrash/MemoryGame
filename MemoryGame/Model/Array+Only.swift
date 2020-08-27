//
//  Array+Only.swift
//  SwiftUIMemoryGame
//
//  Created by ahmed alfrash on 8/27/20.
//  Copyright © 2020 ahmed alfrash. All rights reserved.
//

import Foundation

extension Array {
    var only: Element?{
        count == 1 ? first : nil
    }
}
