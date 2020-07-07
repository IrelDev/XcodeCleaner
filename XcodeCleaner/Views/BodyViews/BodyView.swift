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
            Spacer()
            GeometryReader { geometryReader in
                VStack {
                    PieChartView(items: self.viewModel.getPCItems(), sliceSeparatorColor: .black)
                        .frame(width: geometryReader.size.width / 4, height: geometryReader.size.height / 4)
                        .animation(.easeInOut(duration: 0.3))
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        var viewModel = PieChartViewModel()
        viewModel.createItems(derivedData: [DirectoryModel(name: "Test", size: 2)], deviceSupport: [DirectoryModel(name: "Test", size: 2)], archives: [DirectoryModel(name: "Test", size: 2)])
        
        return BodyView(viewModel: viewModel)
            .environmentObject(ViewModel())
    }
}
