//
//  ContentView.swift
//  AURum
//
//  Created by standard on 2/25/23.
//

import SwiftUI
import RealityKit
import ARKit

let backgroundGrayLevel = 1.0
struct ContentView : View {
    var body: some View {
        ZStack {
            Color(uiColor: UIColor(red: backgroundGrayLevel, green: backgroundGrayLevel, blue: backgroundGrayLevel, alpha: 1.0))
            ARViewContainer().opacity(1)
//                .saturation(0.9)
                .blendMode(.colorBurn)
            Color.white.blendMode(.exclusion)
            TrackListView()
                .padding(30)
        }
            .edgesIgnoringSafeArea(.all)
            .persistentSystemOverlays(.hidden)

    }
}


#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
