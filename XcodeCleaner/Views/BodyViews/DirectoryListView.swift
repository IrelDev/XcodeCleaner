//
//  DirectoryListView.swift
//  XcodeCleaner
//
//  Created by Kirill Pustovalov on 24.06.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import SwiftUI

struct DirectoryListView: View {
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            DropDownView(viewModel: viewModel.getViewModelForItemList(forType: .derivedData))
                .padding()
            Spacer()
            
            DropDownView(viewModel: viewModel.getViewModelForItemList(forType: .deviceSupport))
                .padding()
            Spacer()
            
            DropDownView(viewModel: viewModel.getViewModelForItemList(forType: .archives))
                .padding()
            Spacer()
        }
    }
}

struct ItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        DirectoryListView()
            .environmentObject(ViewModel())
    }
}
