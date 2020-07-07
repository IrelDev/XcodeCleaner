//
//  DividerButtonView.swift
//  XcodeCleaner
//
//  Created by Kirill Pustovalov on 03.07.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import SwiftUI

struct DividerButtonView: View {
    var divider = VStack { Divider() }
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            divider
            Button("\(viewModel.isReadyToBeCleaned ? "Clean": "Scan")") {
                self.viewModel.isReadyToBeCleaned ? self.viewModel.startClean(): self.viewModel.startScan()
            }
            .cornerRadius(25)
            divider
        }
    }
}

struct DividerButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DividerButtonView()
            .environmentObject(ViewModel())
    }
}
