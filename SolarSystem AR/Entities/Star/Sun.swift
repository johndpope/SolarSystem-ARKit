//
//  Sun.swift
//  SolarSystem AR
//
//  Created by Fresneda on 20/07/2017.
//  Copyright © 2017 Fresneda. All rights reserved.
//

import UIKit

class Sun: StellarEntityModel {
    let sunRadius : Float = 109.3
    let sunSize   : Float = 1305700
    let sunMass   : Float = 333000
    let sunDensity: Float = 1408
    let sunGravity: Float = 27.94
    
    let sunDescription: String = "The Sun is the star at the center of the Solar System. It is a nearly perfect sphere of hot plasma, with internal convective motion that generates a magnetic field via a dynamo process. It is by far the most important source of energy for life on Earth. Its diameter is about 109 times that of Earth, and its mass is about 330,000 times that of Earth, accounting for about 99.86% of the total mass of the Solar System. About three quarters of the Sun's mass consists of hydrogen (~73%); the rest is mostly helium (~25%), with much smaller quantities of heavier elements, including oxygen, carbon, neon, and iron."
    
    override init(){
        super.init(entityName: "Sun",
                   entityImage: UIImage.init(named: "sun") ?? UIImage(),
                   radius: k_sunNodeRadius,
                   type: typeStellarEntity.star,
                   shape: shapeStellarEntity.sphere,
                   entityDescription: self.sunDescription
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
