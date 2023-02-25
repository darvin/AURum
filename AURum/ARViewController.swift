//
//  ARViewController.swift
//  AURum
//
//  Created by standard on 2/25/23.
//

import Foundation
import UIKit
import ARKit
import RealityKit

class ARViewController: UIViewController {
    var arView: ARView!
    func makeHandPoseRequest() -> VNDetectHumanHandPoseRequest {
        let r = VNDetectHumanHandPoseRequest { request, error in
            guard error == nil else {
                print("Hand pose recogntion error: \(error!)")
                return
            }
            guard let handPoses = request.results as? [VNHumanHandPoseObservation], !handPoses.isEmpty else {
                // No effects to draw, so clear out current graphics
                return
            }
            
            for hand in handPoses {
                let jointNames = hand.availableJointNames.filter {
                    [.thumbTip, .indexTip, .middleTip, .ringTip, .littleTip].contains($0)
                }
                let groupNames = hand.availableJointsGroupNames
                let joints = jointNames.map { try! hand.recognizedPoint($0) }
                let groups = groupNames.map { try! hand.recognizedPoints($0) }
                print("HAND: \(joints)   ")
            }

        }
        r.maximumHandCount = 2
        r.revision = VNDetectHumanHandPoseRequestRevision1
        
        return r
    }

    lazy var configuration: ARConfiguration = {
        let configuration = ARFaceTrackingConfiguration()
        
        // Enable environment texturing.
//        configuration.environmentTexturing = .automatic
        
        // Enable tracking the user's face during the world tracking session.
//        configuration.userFaceTrackingEnabled = true

        return configuration
    }()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        

        guard ARWorldTrackingConfiguration.supportsUserFaceTracking else {
            fatalError("This sample code requires iOS 13 / iPad OS 13, and an iOS device with a front TrueDepth camera. Note: 2020 iPads do not support user face-tracking while world tracking.")
        }
        arView = ARView(frame: .zero)
        
        
        
        self.view.addSubview(arView)
        
        // 2. View AutoLayout Constraints
        arView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: arView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: arView.trailingAnchor),
            view.topAnchor.constraint(equalTo: arView.topAnchor),
            view.bottomAnchor.constraint(equalTo: arView.bottomAnchor)
        ])


//        arView.session.delegate = self
        
        // We want to run a custom configuration.
        arView.automaticallyConfigureSession = false
        
        #if !targetEnvironment(simulator)
        arView.addCoaching()
        #endif

        arView.renderOptions.insert(.disableMotionBlur)
        
        // Prevent the screen from being dimmed to avoid interuppting the AR experience.
        UIApplication.shared.isIdleTimerDisabled = true

        arView.session.delegate = self
        
        
        let boxAnchor = try! Experience.loadBox()
        
        arView.scene.anchors.append(boxAnchor)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        arView.session.run(configuration)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    
    
    // MARK: - Overrides

    override var prefersStatusBarHidden: Bool {
        // If possible, hide the status bar to improve immersiveness of the AR experience.
        return true
    }


}


extension ARViewController:  ARSessionDelegate {
    
    // MARK: - ARSessionDelegate
    
    /// Add a new robot head when no robot head is currently attached to the camera
    /// and the tracking state is 'normal'.
    /// - Tag: AddHeadPreview
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        
        let pixelBuffer = frame.capturedImage
        let handPoseRequest = makeHandPoseRequest()

        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        do {
            try handler.perform([handPoseRequest])
        } catch {
            assertionFailure("Human Pose Request failed: \(error)")
        }

//        if headPreview == nil, case .normal = frame.camera.trackingState {
//            addHeadPreview()
//        }
//        //...
//        // Only show floating head if the coaching overlay isn't shown.
//        headPreview?.isEnabled = !coachingOverlay.isActive
//
//        // Update the head's appearance to reflect whether the user's face is tracked
//        // or the floating head intersects with already anchored heads.
//        updateHeadPreviewAppearance(for: frame)
    }
    
    /// If there is a floating robot head, update its model
    /// based on the face anchor's transform and current blend shapes.
    /// - Tag: UpdateFacialExpression
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
//        anchors.compactMap { $0 as? ARFaceAnchor }.forEach { headPreview?.update(with: $0) }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
//        displayErrorMessage(for: error)
    }
}
