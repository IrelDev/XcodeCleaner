//
//  DropDownView.swift
//  XcodeCleaner
//
//  Created by Kirill Pustovalov on 04.07.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import SwiftUI

struct DropDownView: View {
    @State var isExpanded = false
    var viewModel: DirectoryListViewModelProtocol
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                HStack {
                    Text("\(viewModel.directories.count == 0 ? "": isExpanded ? "▲": "▼") \(viewModel.directoryName)")
                        .font(.title)
                        .fontWeight(.heavy)
                    Spacer()
                    
                    Text("\(BytesToStringFormatter.format(size: viewModel.totalSize))")
                        .foregroundColor(viewModel.circleColor)
                        .font(.title)
                        .fontWeight(.heavy)
                    
                    Circle()
                        .fill(viewModel.circleColor)
                        .frame(width: 30, height: 30)
                }
            }.onTapGesture {
                self.isExpanded.toggle()
            }
            if viewModel.directories.count > 0 {
                if isExpanded {
                    VStack {
                        GeometryReader { geometryReader in
                            List {
                                VStack {
                                    ForEach(0 ..< self.viewModel.directories.count) { index in
                                        HStack {
                                            Text(self.viewModel.directories[index].name)
                                                .lineLimit(1)
                                            Spacer()
                                            Text("\(BytesToStringFormatter.format(size: self.viewModel.directories[index].size))")
                                                .foregroundColor(self.viewModel.circleColor)
                                        }
                                    }
                                }
                            }
                            .font(.body)
                        }
                    }
                }
            }
        }
        .animation(.easeIn(duration: 0.3))
    }
}

struct DropDownView_Previews: PreviewProvider {
    static var previews: some View {
        DropDownView(viewModel: DirectoryListViewModel(directoryName: "Test", directories: [DirectoryModel(name: "/Url", size: 15)], circleColor: .green))
    }
}
