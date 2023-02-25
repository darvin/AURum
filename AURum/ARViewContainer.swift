//
//  ARViewContainer.swift
//  AURum
//
//  Created by standard on 2/25/23.
//

import Foundation

import SwiftUI
import ARKit
import RealityKit



struct ARViewContainer: UIViewControllerRepresentable  {
    func makeUIViewController(context: Context) -> ARViewController {
        return ARViewController()
    }
    
    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = ARViewController
    
    
    

    
        
}
