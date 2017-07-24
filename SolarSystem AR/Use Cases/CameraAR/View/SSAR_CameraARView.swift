//
//  SSAR_CameraARView.swift
//  SolarSystem AR
//
//  Created by Fresneda on 10/07/2017.
//  Copyright © 2017 Fresneda. All rights reserved.
//

import UIKit
import ARKit
import SceneKit
import Photos

//------------------------------------------
//  MARK: - Life cycle
//------------------------------------------
class SSAR_CameraARView: UIViewController {
    
    //MARK: - Outlets vars
    @IBOutlet weak var sceneView                : ARSCNView!
    @IBOutlet weak var resetExperienceButton    : UIButton!
    @IBOutlet weak var screenCaptureButton      : UIButton!
    @IBOutlet weak var showEntitiesTableButton  : UIButton!
    @IBOutlet weak var entitiesTableView        : UITableView!
    
    @IBOutlet weak var fxBackgroundView         : UIView!
    
    //MARK: - AR Vars
    let session : ARSession = ARSession()
    var sessionConfig : ARWorldTrackingSessionConfiguration?
    
    //MARK: - Other Vars
    var presenter: SSAR_CameraARPresenterProtocol?
    var stellarEntities: [StellarEntityModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
}

//------------------------------------------
//  MARK: - Setup
//------------------------------------------
extension SSAR_CameraARView{
    func setupView(){
        self.sceneView.delegate = self
        
        self.fxBackgroundView.layer.cornerRadius = self.fxBackgroundView.frame.height/2
        self.fxBackgroundView.clipsToBounds = true
        
        self.entitiesTableView.delegate = self
        self.entitiesTableView.dataSource = self
        self.entitiesTableView.register(UINib.init(nibName: "EntityCell", bundle: nil), forCellReuseIdentifier: "EntityCell")
        self.entitiesTableView.estimatedRowHeight = 50
        self.entitiesTableView.layer.cornerRadius = self.fxBackgroundView.frame.height/2
        self.entitiesTableView.clipsToBounds = true
        
    }
    
    func setupSceneView(){
        //Check to see if active reality is supported
        guard ARSessionConfiguration.isSupported else {
            return
        }
        
        //Set up the ARSessionConfiguration
            // Configure session
        self.sessionConfig = ARWorldTrackingSessionConfiguration()
        guard let worldSessionConfig = self.sessionConfig else{
            return
        }
        worldSessionConfig.worldAlignment = .gravity
        worldSessionConfig.planeDetection = .horizontal
        worldSessionConfig.isLightEstimationEnabled = true
        
            //Set render settings
        self.sceneView.antialiasingMode = .multisampling4X
        self.sceneView.automaticallyUpdatesLighting = true
        
        self.sceneView.preferredFramesPerSecond = 60
        self.sceneView.contentScaleFactor = 1.3
        
            //Run the session with the new configurarion and set it delegate
        self.sceneView.session.run(worldSessionConfig, options: [.resetTracking, .removeExistingAnchors])
        self.sceneView.delegate = self 
    }
}
//------------------------------------------
//  MARK: - Actions
//------------------------------------------
extension SSAR_CameraARView{
    @IBAction func resetExperience(_ sender: Any){
        self.resetExperience()
    }
    
    @IBAction func screenCapture(_ sender: Any){
        self.screenCapture()
    }
    
    @IBAction func showEntitiesTable(_ sender: Any){
        self.interactEntitiesTable()
    }
}

//------------------------------------------
//  MARK: - SSAR_CameraARView Protocol
//------------------------------------------
extension SSAR_CameraARView : SSAR_CameraARViewProtocol{
    
    //Show & hide a list of available entities
    func interactEntitiesTable() {
        self.entitiesTableView.reloadData()

        UIView.animate(withDuration: 0.3, animations: {
            self.entitiesTableView.isHidden = !self.entitiesTableView.isHidden
            self.resetExperienceButton.isHidden = !self.resetExperienceButton.isHidden
            self.screenCaptureButton.isHidden = !self.screenCaptureButton.isHidden
            
        }, completion: nil)
    }
    
    //Clean all nodes in scene view
    func resetExperience() {
        print("Reset Experience")
    }
    
    //Get a snapshot from scene view and try to save it on photos album
    func screenCapture() {
        guard self.screenCaptureButton.isEnabled else {
            return
        }
        
        let takeScreenshotBlock = {
            UIImageWriteToSavedPhotosAlbum(self.sceneView.snapshot(), nil, nil, nil)
            DispatchQueue.main.async {
                // Briefly flash the screen.
                let flashOverlay = UIView(frame: self.sceneView.frame)
                flashOverlay.backgroundColor = UIColor.white
                self.sceneView.addSubview(flashOverlay)
                UIView.animate(withDuration: 0.25, animations: {
                    flashOverlay.alpha = 0.0
                }, completion: { _ in
                    flashOverlay.removeFromSuperview()
                })
            }
        }
        
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            takeScreenshotBlock()
        case .restricted, .denied:
            break
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (authorizationStatus) in
                if authorizationStatus == .authorized {
                    takeScreenshotBlock()
                }
            })
        }
    }
    
    func fillSolarSystem(with entities: [StellarEntityModel]) {
        self.stellarEntities = entities
    }
}

//------------------------------------------
//  MARK: - ARSCN Delegate
//------------------------------------------
extension SSAR_CameraARView : ARSCNViewDelegate{
    
    //Create floor nodes when ARKit detect a plane
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else{ return }
        
        let newPlane = SCNPlane.init(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        
        let planeNode = SCNNode.init(geometry: newPlane)
        planeNode.position = SCNVector3.init(planeAnchor.center.x, 0, planeAnchor.center.z)
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
        
        node.addChildNode(planeNode)
    }
    
    //When a plane node is updated, remove all existing plane nodes and create a new one with
    //the new anchor
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else{ return }
        
        // Remove existing plane nodes
        node.enumerateChildNodes {
            (childNode, _) in
            childNode.removeFromParentNode()
        }

//        let planeNode = createPlaneNode(anchor: planeAnchor)
//
//        node.addChildNode(planeNode)
    }
    
    //Remove existing plane nodes
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {

        node.enumerateChildNodes {
            (childNode, _) in
            childNode.removeFromParentNode()
        }
    }
}

//------------------------------------------
//  MARK: - UITableView Delegate DataSource
//------------------------------------------
extension SSAR_CameraARView : UITableViewDelegate, UITableViewDataSource{
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stellarEntities.count
    }
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntityCell") as! EntityCellTableViewCell
        
        let entity = self.stellarEntities[indexPath.row]
        cell.set(forEntity: entity)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.showEntityDetails(for: self.stellarEntities[indexPath.row])
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.entitiesTableView.frame.height
    }
    
}
