//
//  ContentView.swift
//  AURum
//
//  Created by standard on 2/25/23.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    var body: some View {
        ZStack {
            ARViewContainer()
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
