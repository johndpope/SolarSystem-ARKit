//
//  SSAR_CameraARProtocols.swift
//  SolarSystem AR
//
//  Created by Fresneda on 10/07/2017.
//  Copyright © 2017 Fresneda. All rights reserved.
//

import UIKit

//--------------------------------
// PRESENTER -> VIEW
//--------------------------------
protocol SSAR_CameraARViewProtocol : class{
    var presenter : SSAR_CameraARPresenterProtocol? {get set}
    
    func fillSolarSystem(with entities: [StellarEntityModel])
    
    func setupView()
    func setupSceneView()
    
    func interactEntitiesTable()
    func resetExperience()
    func screenCapture()
}

//--------------------------------
// PRESENTER -> WIREFRAME
//--------------------------------
protocol SSAR_CameraARWireFrameProtocol : class{
    static func createCameraARModule() -> UIViewController
    
    func presentEntityDetailScreen(from view: SSAR_CameraARViewProtocol, forEntity entity: StellarEntityModel)
    
}

//--------------------------------
// VIEW -> PRESENTER
//--------------------------------
protocol SSAR_CameraARPresenterProtocol : class{
    var view        : SSAR_CameraARViewProtocol? {get set}
    var interactor  : SSAR_CameraARInteractorInputProtocol? {get set}
    var wireframe   : SSAR_CameraARWireFrameProtocol? {get set}
    
    func viewDidLoad()
    func showEntityDetails(for entity: StellarEntityModel)
}

//--------------------------------
// INTERACTOR -> PRESENTER
//--------------------------------
protocol SSAR_CameraARInteractorOutputProtocol : class{
    //recover data from entities
}

//--------------------------------
// PRESENTER -> INTERACTOR
//--------------------------------
protocol SSAR_CameraARInteractorInputProtocol : class{
    var presenter   : SSAR_CameraARPresenterProtocol? {get set}
    //store data
}
