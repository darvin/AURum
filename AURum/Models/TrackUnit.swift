//
//  TrackUnit.swift
//  AURum
//
//  Created by standard on 2/25/23.
//

import Foundation
import AudioToolbox

extension AudioComponentDescription: Codable {
    enum CodingKeys: String, CodingKey {
        case componentType
        case componentSubType
        case componentManufacturer
        case componentFlags
        case componentFlagsMask
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(componentType, forKey: .componentType)
        try container.encode(componentSubType, forKey: .componentSubType)
        try container.encode(componentManufacturer, forKey: .componentManufacturer)
        try container.encode(componentFlags, forKey: .componentFlags)
        try container.encode(componentFlagsMask, forKey: .componentFlagsMask)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let componentType = try container.decode(UInt32.self, forKey: .componentType)
        let componentSubType = try container.decode(UInt32.self, forKey: .componentSubType)
        let componentManufacturer = try container.decode(UInt32.self, forKey: .componentManufacturer)
        let componentFlags = try container.decode(UInt32.self, forKey: .componentFlags)
        let componentFlagsMask = try container.decode(UInt32.self, forKey: .componentFlagsMask)
        self.init(componentType: OSType(componentType),
                  componentSubType: OSType(componentSubType),
                  componentManufacturer: OSType(componentManufacturer),
                  componentFlags: componentFlags,
                  componentFlagsMask: componentFlagsMask)
    }
}


struct TrackUnit: Codable {
    var id = UUID()
    var componentDescription: AudioComponentDescription
}

extension TrackUnit: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: TrackUnit, rhs: TrackUnit) -> Bool {
        return lhs.id == rhs.id
    }
}


extension TrackUnit: Identifiable {
    
}
