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
    
    @ObservedObject var observableFilterModel = ObservableFilterModel()
    var sortMethods = ["Name", "Size"]
    
    var body: some View {
        VStack(spacing: 5) {
            
            HStack {
                HStack {
                    Text("\(viewModel.directories.count == 0 ? "": isExpanded ? "▲": "▼") \(viewModel.directoryName)")
                        .font(.system(size: 22))
                        .fontWeight(.heavy)
                    Spacer()
                    
                    Text("\(BytesToStringFormatter.format(size: viewModel.totalSize))")
                        .foregroundColor(viewModel.circleColor)
                        .font(.system(size: 22))
                        .fontWeight(.heavy)
                    
                    Circle()
                        .fill(viewModel.circleColor)
                        .frame(width: 22, height: 22)
                }
            }.onTapGesture {
                withAnimation {
                    self.isExpanded.toggle()
                }
            }
            if viewModel.directories.count > 0 {
                let sortedArray =  self.viewModel.directories.sorted(by: { (model1, model2) -> Bool in
                    return (observableFilterModel.sortMethod == 0) ? model1.name.lowercased() < model2.name.lowercased() : model1.size > model2.size
                })
                if isExpanded {
                    VStack {
                        GeometryReader { geometryReader in
                            List {
                                HStack {
                                    Text("Filter by")
                                        .font(.headline)
                                    Spacer()
                                    Spacer()
                                    Picker(selection: $observableFilterModel.sortMethod, label: Text("")) {
                                        ForEach(0 ..< sortMethods.count) { index in
                                            Text(self.sortMethods[index]).tag(index)
                                        }
                                    }.pickerStyle(SegmentedPickerStyle())
                                    .frame(width: 200)
                                                .clipped()
                                }
                                VStack {
                                    ForEach(0 ..< sortedArray.count) { index in
                                        HStack {
                                            Text(sortedArray[index].name)
                                                .lineLimit(1)
                                            Spacer()
                                            Text("\(BytesToStringFormatter.format(size: sortedArray[index].size))")
                                                .foregroundColor(self.viewModel.circleColor)
                                        }
                                    }
                                }
                            }
                            .cornerRadius(10)
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
