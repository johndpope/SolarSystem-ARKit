//
//  StellarEntityModel.swift
//  SolarSystem AR
//
//  Created by Fresneda on 10/07/2017.
//  Copyright © 2017 Fresneda. All rights reserved.
//

import SceneKit

enum typeStellarEntity{
    case star, planet, satellite
}
enum shapeStellarEntity{
    case sphere, tube
}

class StellarEntityModel : SCNNode{
    
    var entityName  : String?
    var entityImage : UIImage?
    var radius      : Float?
    var type        : typeStellarEntity?
    var shape       : shapeStellarEntity?
    var entityParent: StellarEntityModel?
    
    var entityDescription   : String?
    
    var modelLoaded : Bool = false
    
    override init() {
        super.init()
        self.name = "Virtual object root node"
    }
    
    init(entityName: String,
         entityImage: UIImage,
         radius: Float,
         type: typeStellarEntity,
         shape: shapeStellarEntity,
         entityParent: StellarEntityModel? = nil,
         entityDescription: String) {
        
        super.init()
        
        self.entityName = entityName
        self.entityImage = entityImage
        self.radius = radius
        self.type = type
        self.shape = shape
        self.entityParent = entityParent
        
        self.entityDescription = entityDescription
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadModel(){
        
    }
    func unloadModel() {
        for child in self.childNodes {
            child.removeFromParentNode()
        }
        
        modelLoaded = false
    }

}

extension StellarEntityModel{
    static let availableEntities : [StellarEntityModel] = [
        Sun()
//        Mercury(),
//        Venus(),
//        Earth(),
//        Mars(),
//        Jupiter(),
//        Saturn(),
//        Uranus(),
//        Neptune()
    ]
}

struct CollisionCategory : OptionSet {
    let rawValue: Int
    
    static let bottom = CollisionCategory(rawValue: 1 << 0)
    static let cube = CollisionCategory(rawValue: 1 << 1)
}
