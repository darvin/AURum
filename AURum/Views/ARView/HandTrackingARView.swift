//
//  HandTrackingARView.swift
//  AURum
//
//  Created by standard on 2/25/23.
//

import Foundation

import BodyTracking
import RealityKit
import ARKit


class HandTrackingARView: ARView {
    

    private var handTrackers: [HandTracker3D]!
    
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        guard #available(iOS 14, *) else {
            let title = "Uh oh..."
            let errorMessage = "Hand tracking requires iOS 14.0 or later"
            print(errorMessage)
            showAlert(title: title, message: errorMessage)
            return
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        runNewConfig()
        
        self.handTrackers = [HandTracker3D(arView: self),
                             HandTracker3D(arView: self)]
        
        let sceneAnchor = AnchorEntity()
        
        self.scene.addAnchor(sceneAnchor)
        
        for handTracker in handTrackers {
            sceneAnchor.addChild(handTracker)
        }
        
        makeHandJointsVisible()
        
        //Can modify this to improve performance.
        //handTracker.requestRate = .quarter
    }
    
    func runNewConfig(){
        // Create a session configuration
        let configuration = ARFaceTrackingConfiguration()
        session.run(configuration)
    }
    
    ///This is an example for how to show multiple joints, iteratively.
    private func makeHandJointsVisible(){
        
        //Another way to attach views to the skeletion, but iteratively this time:
        zip([UIColor.white,
             UIColor.red,
             UIColor.blue,
             UIColor.green,
             UIColor.yellow], HandTracker2D.allHandJoints.filter({
            [
                .thumbTip,
                .indexTip,
                .middleTip,
                .ringTip,
                .littleTip].contains($0)
        })).forEach { color, joint in
            for handTracker in handTrackers {
                let sphere = Entity.makeSphere(color: color, radius: 0.0037, isMetallic: true)

                handTracker.attach(thisEnt: sphere, toThisJoint: joint)

            }
        }
    }

    /// This helps prevent memory leaks.
    func stopSession(){
        for handTracker in handTrackers {
            handTracker.destroy()
        }

       self.session.pause()
       self.scene.anchors.removeAll()
   }
    
    deinit {
        self.stopSession()
    }
    
    
    //required function.
    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
