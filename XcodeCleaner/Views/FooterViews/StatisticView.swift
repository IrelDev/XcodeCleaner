//
//  StatisticView.swift
//  XcodeCleaner
//
//  Created by Kirill Pustovalov on 02.07.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import SwiftUI

struct StatisticView: View {
    var totalCleaned: String = String(format: "%.2f", 22.7800)
    var lastTimeCleaned: String?
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text("Total cleaned: \(totalCleaned) GB")
            Text("Last time cleaned: \(lastTimeCleaned ?? "none")")
            Text("Github: IrelDev")
        }
        .font(.footnote)
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView()
    }
}
