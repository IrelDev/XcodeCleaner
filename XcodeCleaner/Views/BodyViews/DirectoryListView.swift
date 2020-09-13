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
            
            Group {
                ForEach(DirectoryType.allCases, id: \.self) { type in

                    DropDownView(viewModel: self.viewModel.getViewModelForItemList(forType: type))
                        .padding(.bottom)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct ItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        DirectoryListView()
            .environmentObject(ViewModel())
    }
}
