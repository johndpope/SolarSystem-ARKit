//
//  EntityCellTableViewCell.swift
//  SolarSystem AR
//
//  Created by Fresneda on 10/07/2017.
//  Copyright © 2017 Fresneda. All rights reserved.
//

import UIKit

class EntityCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var entityImage: UIImageView!
    @IBOutlet weak var entityName: UILabel!
    
    func set(forEntity entity: StellarEntityModel) {
        self.selectionStyle = .none
        
        self.entityName.text = entity.entityName
        
        self.entityImage.layer.cornerRadius = self.entityImage.frame.width/2
        self.entityImage.clipsToBounds = true
        
        self.entityImage.image = entity.entityImage
    }
}

