//
//  SSAR_CameraARWireFrame.swift
//  SolarSystem AR
//
//  Created by Fresneda on 10/07/2017.
//  Copyright © 2017 Fresneda. All rights reserved.
//

import UIKit

class SSAR_CameraARWireFrame: SSAR_CameraARWireFrameProtocol {
    
    static func createCameraARModule() -> UIViewController {
        let view = self.mainStoryboard.instantiateViewController(withIdentifier: "SSAR_CameraARView") as! SSAR_CameraARView
        
        //        guard let view = navigationController.childViewControllers.first as? SSAR_CameraARView else{
        //            assertionFailure("Unexpected View")
        //            return UIViewController()
        //        }
        
        let presenter   : SSAR_CameraARPresenterProtocol & SSAR_CameraARInteractorOutputProtocol = SSAR_CameraARPresenter()
        let interactor  : SSAR_CameraARInteractorInputProtocol = SSAR_CameraARInteractor()
        let wireFrame   : SSAR_CameraARWireFrameProtocol = SSAR_CameraARWireFrame()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.wireframe = wireFrame
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        return view
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "SSAR_CameraAR", bundle: Bundle.main)
    }
    
    func presentEntityDetailScreen(from view: SSAR_CameraARViewProtocol, forEntity entity: StellarEntityModel) {
//        let postDetailViewController = PostDetailWireFrame.createPostDetailModule(forPost: post)
//
//        if let sourceView = view as? UIViewController {
//            sourceView.navigationController?.pushViewController(postDetailViewController, animated: true)
//        }
    }
}
