//
//  FooterView.swift
//  XcodeCleaner
//
//  Created by Kirill Pustovalov on 02.07.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import SwiftUI

struct FooterView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        return VStack {
            DividerButtonView()
                .offset(y: 16)
            
            HStack {
                ScanProgressView(progress: CGFloat(viewModel.scanProgress))
                    .padding(10)
                
                Text("\(BytesToStringFormatter.format(size: viewModel.totalSize, allowedUnits: [.useGB]))")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.pink)
                    .frame(width: 100)
                    .lineLimit(1)
                
                StatisticView()
                    .padding(10)
            }
        }
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
            .environmentObject(ViewModel())
    }
}
