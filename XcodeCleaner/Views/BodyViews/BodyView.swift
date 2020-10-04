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
        GeometryReader { globalGeometry in
            HStack {
                DirectoryListView()
                    .frame(width: 450)
                GeometryReader { geometryReader in
                    PieChartView(items: self.viewModel.getPCItems())
                        .frame(width: globalGeometry.size.width / 2, height: globalGeometry.size.height / 2)
                        .position(CGPoint(x: geometryReader.size.width / 2, y: geometryReader.size.height / 2))
                        .animation(.easeIn(duration: 1.0))
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        var viewModel = PieChartViewModel()
        viewModel.createItems(derivedData: [DirectoryModel(name: "Test", size: 2)], iOSDeviceSupport: [DirectoryModel(name: "Test", size: 2)], watchOSDeviceSupport: [DirectoryModel(name: "Test", size: 4)], archives: [DirectoryModel(name: "Test", size: 2)], iOSDeviceLogs:  [DirectoryModel(name: "Test", size: 2)], documentationCache:  [DirectoryModel(name: "Test", size: 2)])
        
        return BodyView(viewModel: viewModel)
            .environmentObject(ViewModel())
    }
}
