//
//  TrackListView.swift
//  AURum
//
//  Created by standard on 2/25/23.
//

import Foundation
import SwiftUI

let plusButtonWidth = 40.0

struct TrackListView : View {
    @StateObject
    var viewModel = TrackListViewModel()
    
    var body: some View {
        HStack {
            ForEach(viewModel.tracks) { track in
                TrackView(viewModel: viewModel.trackViewModel(for: track))
                
            }
            Button {
                viewModel.addTrack()
            } label: {
                
                Image(systemName: "plus")
                    .resizable()
                    .padding(6)
                    .frame(width: plusButtonWidth, height: plusButtonWidth)
                    .background(Color.gray)
                    .clipShape(Circle())
                    .foregroundColor(.white)
            }

        }
    }
}


#if DEBUG
struct TrackListView_Previews : PreviewProvider {
    static var previews: some View {
        TrackListView()
    }
}
#endif
