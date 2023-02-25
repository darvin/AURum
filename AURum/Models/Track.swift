//
//  Track.swift
//  AURum
//
//  Created by standard on 2/25/23.
//

import Foundation


struct Track: Codable {
    var id = UUID()
    var name: String
    var units: [TrackUnit] = [TrackUnit]()
}

extension Track: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Track, rhs: Track) -> Bool {
        return lhs.id == rhs.id
    }
}


extension Track: Identifiable {
    
}
