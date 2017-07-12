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
    var size        : Float?
    var radius      : Float?
    var density     : Float?
    var gravity     : Float?
    var type        : typeStellarEntity?
    var shape       : shapeStellarEntity?
    var entityParent: StellarEntityModel?
    
    var entityDescription   : String?
    
    override init() {
        super.init()
        self.name = "Virtual object root node"
    }
    
    init(entityName: String,
         entityImage: UIImage,
         size: Float,
         radius: Float,
         density: Float,
         gravity: Float,
         type: typeStellarEntity,
         shape: shapeStellarEntity,
         entityParent: StellarEntityModel? = nil,
         entityDescription: String) {
        
        super.init()
        
        self.entityName = entityName
        self.entityImage = entityImage
        self.size = size
        self.radius = radius
        self.density = density
        self.gravity = gravity
        self.type = type
        self.shape = shape
        self.entityParent = entityParent
        
        self.entityDescription = entityDescription
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
