//
//  SSAR_CameraARPresenter.swift
//  SolarSystem AR
//
//  Created by Fresneda on 10/07/2017.
//  Copyright © 2017 Fresneda. All rights reserved.
//

import UIKit

class SSAR_CameraARPresenter: SSAR_CameraARPresenterProtocol {
    
    var view        : SSAR_CameraARViewProtocol?
    var interactor  : SSAR_CameraARInteractorInputProtocol?
    var wireframe   : SSAR_CameraARWireFrameProtocol?
    
    func viewDidLoad() {
        print("viewDidLoad")
    }
    
    func showEntityDetails(for entity: StellarEntityModel) {
        wireframe?.presentEntityDetailScreen(from: view!, forEntity: entity)
    }
    
}

extension SSAR_CameraARPresenter : SSAR_CameraARInteractorOutputProtocol{
    
}
