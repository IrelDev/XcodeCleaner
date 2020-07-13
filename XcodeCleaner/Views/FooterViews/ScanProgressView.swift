//
//  ScanProgressView.swift
//  XcodeCleaner
//
//  Created by Kirill Pustovalov on 03.07.2020.
//  Copyright © 2020 Kirill Pustovalov. All rights reserved.
//

import SwiftUI

struct ScanProgressView: View {
    var progress: CGFloat = 0.0
    var height: CGFloat = 8
    var startPoint = CGPoint(x: 0, y: 0)
    
    var body: some View {
        GeometryReader { geometryReader in
            ZStack {
                Path { path in
                    path.move(to: self.startPoint)
                    path.addRoundedRect(
                        in: CGRect(x: self.startPoint.x, y: self.startPoint.y, width: geometryReader.size.width, height: self.height),
                        cornerSize: CGSize(width: self.height / 2 , height: self.height / 2),
                        style: .circular)
                }
                
                Path { path in
                    path.move(to: self.startPoint)
                    path.addRoundedRect(
                        in: CGRect(x: self.startPoint.x, y: self.startPoint.y, width: geometryReader.size.width * self.progress, height: self.height),
                        cornerSize: CGSize(width: self.height / 2, height: self.height / 2),
                        style: .circular)
                }
                .fill(LinearGradient(gradient: Gradient(colors: [Color(.cyan), .pink, .orange, .purple, .gray]), startPoint: .leading, endPoint: .trailing))
                .animation(.easeInOut)
            }
            .frame(width: geometryReader.size.width, height: self.height)
        }
        .frame(height: self.height)
    }
}

struct ScanProgressView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ScanProgressView()
            ScanProgressView(progress: 1.0)
        }
    }
}
