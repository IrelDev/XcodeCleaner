//
//  ContentView.swift
//  XcodeCleaner
//
//  Created by Kirill Pustovalov on 07.07.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        VStack {
            BodyView(viewModel: viewModel.getViewModelForPieChart())
            FooterView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
