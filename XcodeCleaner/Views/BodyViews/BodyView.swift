//
//  BodyView.swift
//  XcodeCleaner
//
//  Created by Kirill Pustovalov on 02.07.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import SwiftUI

struct BodyView: View {
    var viewModel: PieChartViewModelProtocol
    
    var body: some View {
        HStack {
            DirectoryListView()
            .frame(width: 350)
            Spacer()
            GeometryReader { geometryReader in
                VStack {
                    PieChartView(items: self.viewModel.getPCItems())
                        .frame(width: geometryReader.size.width / 2, height: geometryReader.size.height / 2)
                        .animation(.easeIn(duration: 1.0))
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        var viewModel = PieChartViewModel()
        viewModel.createItems(derivedData: [DirectoryModel(name: "Test", size: 2)], deviceSupport: [DirectoryModel(name: "Test", size: 2)], archives: [DirectoryModel(name: "Test", size: 2)], iOSDeviceLogs:  [DirectoryModel(name: "Test", size: 2)], documentationCache:  [DirectoryModel(name: "Test", size: 2)])
        
        return BodyView(viewModel: viewModel)
            .environmentObject(ViewModel())
    }
}
