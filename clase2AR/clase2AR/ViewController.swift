//
//  ViewController.swift
//  clase2AR
//
//  Created by dam2 on 8/5/24.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        
        self.sceneView.delegate = self
    }
    
    @IBAction func onButton(_ sender: Any) {
        
        guard let pointOfView = sceneView.pointOfView else {return}
        
        // Obtiene la posición de la cámara
        let transform = pointOfView.transform
        
        //Obtiene la orientación de la cámara
        let orientation = SCNVector3(transform.m31, transform.m32, transform.m33)
        
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        
        let frontOfCamera = orientation + location
        
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 0, y: 0))
//        path.addLine(to: CGPoint(x: 0, y: 0.2))
//        path.addLine(to: CGPoint(x: 0.2, y: 0.3))
//        path.addLine(to: CGPoint(x: 0.4, y: 0.2))
//        path.addLine(to: CGPoint(x: 0.4, y: 0))
//        
//        let shape = SCNShape(path: path, extrusionDepth: 0.3)
//        
//        let node = SCNNode(geometry: shape)
//        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
//        node.position = SCNVector3(x: 0, y: 0, z: -1)
//        node.name = "Yusepe"
//        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
    @IBAction func offButton(_ sender: Any) {
        self.sceneView.session.pause()
        
        self.sceneView.scene.rootNode.enumerateChildNodes{(node, _) in
            if node.name != "Yusepe" {
                node.removeFromParentNode()
            }
        }
        
    }
}

extension ViewController: ARSCNViewDelegate {
    func renderer(_ renderer: any SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        print("rendering")
        
        guard let pointOfView = sceneView.pointOfView else {return}
        
        // Obtiene la posición de la cámara
        let transform = pointOfView.transform
        
        //Obtiene la orientación de la cámara
        let orientation = SCNVector3(transform.m31, transform.m32, transform.m33)
        
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        
        let frontOfCamera = orientation + location
        
        //Dibujar una esfera
        DispatchQueue.main.async {
            
            //Eliminar todos los nodos
            self.sceneView.scene.rootNode.enumerateChildNodes{(node, _) in
                if node.name == "Yusepe" {
                    node.removeFromParentNode()
                }
            }
            
            if self.boton.is {
                
            } else {
                let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.02))
                sphereNode.position = frontOfCamera
                sphereNode.name = "Yusepe"
                self.sceneView.scene.rootNode.addChildNode(sphereNode)
            }
            

        }
    }
}

func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3(left.x + right.x, left.y + right.y, left.z + right.z)
}
