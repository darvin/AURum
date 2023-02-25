//
//  TrackView.swift
//  AURum
//
//  Created by standard on 2/25/23.
//

import Foundation
import SwiftUI

struct TrackView : View {
    @ObservedObject
    var viewModel: TrackViewModel
    @State private var showingAddTrackUnitView = false

    
    
    var body: some View {
        VStack {
            VSlider(value: $viewModel.volume,
                    in: 0...1.0,
                    step: 0.0001,
                    onEditingChanged: { print($0 ? "Moving Slider" : "Stopped moving Slider") })
            Text("\(viewModel.track.name)")

            
            
            Button {
                showingAddTrackUnitView.toggle()
            } label: {
                
                Image(systemName: "plus")
                    .resizable()
                    .padding(6)
                    .frame(width: plusButtonWidth, height: plusButtonWidth)
                    .background(Color.green)
                    .clipShape(Circle())
                    .foregroundColor(.white)
            }
            .sheet(isPresented: $showingAddTrackUnitView) {
                AddNewTrackUnitView(track: $viewModel.track)
            }
        }
    }
    
}
    
