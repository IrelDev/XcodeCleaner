//
//  StatisticView.swift
//  XcodeCleaner
//
//  Created by Kirill Pustovalov on 02.07.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import SwiftUI

struct StatisticView: View {
    var viewModel: StatisticViewModelProtocol
    var body: some View {
        VStack(alignment: .trailing) {
            Text("Total cleaned: \(viewModel.getTotalSize())")
            Text("Last cleanup: \(viewModel.getLastDate())")
            Text("Github: IrelDev")
        }
        .font(.footnote)
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView(viewModel: StatisticViewModel(statistic: StatisticModel(totalCleaned: 250000, lastTimeCleaned: Date())))
    }
}
