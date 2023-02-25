//
//  TrackViewModel.swift
//  AURum
//
//  Created by standard on 2/25/23.
//

import Foundation


class TrackViewModel: ObservableObject {
    @Published
    var track: Track
    
    init(track: Track) {
        self.track = track
    }
    
    @Published
    var volume: Float = 1.0
}
    
