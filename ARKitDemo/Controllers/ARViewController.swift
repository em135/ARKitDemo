//
//  ViewController.swift
//  ARKitDemo
//
//  Created by Emil Nielsen on 01/11/2019.
//  Copyright © 2019 Emil Nielsen. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ARViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    private var configuation: ARWorldTrackingConfiguration!
    private var imageMapper: ImageMapper!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // AR configurations
        configuation = ARWorldTrackingConfiguration()
        configuation.planeDetection = [.horizontal, .vertical]
        configuation.detectionImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil)

        // Set a scene to the view
        sceneView.scene = SCNScene()
        sceneView.delegate = self
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        sceneView.session.run(configuation)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imageMapper = ImageMapper()
    }

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let imageAnchor = anchor as? ARImageAnchor {
            print("Found image")
            handleImageDetected(node: node, imageAnchor: imageAnchor)
        } else if let planeAnchor = anchor as? ARPlaneAnchor {
            print("Found plane")
            handlePlaneDetected(node: node, planeAnchor: planeAnchor)
        }
    }

    private func handleImageDetected(node: SCNNode, imageAnchor: ARImageAnchor) {
        let referenceImage = imageAnchor.referenceImage

        if let imageID = referenceImage.name, let image = imageMapper.images[imageID] {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: image.name, message: "Author: \(image.author).\nPainted in \(image.year).", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    private func handlePlaneDetected(node: SCNNode, planeAnchor: ARPlaneAnchor) {
        DispatchQueue.main.async {
            let cupScene = SCNScene(named: "art.scnassets/cup.usdz")
            let cupNode = cupScene?.rootNode.childNode(withName: "cup", recursively: true)
            if let model = cupNode {
                model.position = SCNVector3Make(planeAnchor.center.x, planeAnchor.center.y, planeAnchor.center.z)
                node.addChildNode(model)
            }
        }
    }

}
