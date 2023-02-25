//
//  TrackListViewModel.swift
//  AURum
//
//  Created by standard on 2/25/23.
//

import Foundation


class TrackListViewModel: ObservableObject {
    @Published
    var tracks: [Track] = [Track]()
    
    private var trackViewModels = [Track: TrackViewModel]()
    
    public func addTrack() {
        tracks.append(Track(name:"Track \(tracks.count)"))
    }
    
    public func trackViewModel(for track:Track) -> TrackViewModel {
        if !trackViewModels.keys.contains(track) {
            trackViewModels[track] = TrackViewModel(track:track)
        }
        return trackViewModels[track]!
    }
    
}
