//
//  ObservableFilterModel.swift
//  XcodeCleaner
//
//  Created by iMokhles on 29/10/2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import Combine
import SwiftUI

class ObservableFilterModel: ObservableObject {
    
    let objectWillChange = ObservableObjectPublisher()

        var sortMethod = 0 {
            willSet {
                objectWillChange.send()
            }
        }
    
}
