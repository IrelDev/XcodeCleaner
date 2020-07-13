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
        ZStack {
            VStack {
                BodyView(viewModel: viewModel.getViewModelForPieChart())
                FooterView()
            }
            .alert(isPresented: $viewModel.isAlertPresented) {
                Alert(title: Text("Clean finished"), message: Text("\(BytesToStringFormatter.format(size: viewModel.totalSize)) was successfully cleaned!"), dismissButton: .default(
                    Text("Ok"), action: {
                        self.viewModel.cleanBeforeScan()
                }))}
                .frame(minWidth: 800, minHeight: 550)
            
            if viewModel.isCleanStarted {
                ActivityIndicatorView()
                    .frame(width: 200, height: 200)
                    .foregroundColor(Color(.labelColor))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
