//
//  EstadosTableViewCell.swift
//  DeOlhoNaRouanet
//
//  Created by Student on 11/30/16.
//  Copyright © 2016 Grupo: De Olho na Rouanet. All rights reserved.
//

import UIKit

class EstadosTableViewCell: UITableViewCell {

    var flagImagePath: String?
    @IBOutlet weak var flagImageView: UIImageView!
    
    @IBOutlet weak var nomeUFLabel: UILabel!
    
    @IBOutlet weak var estadoCheckImageView: UIImageView!
    
    var indice:Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if var estadosAtivos = NSUserDefaults().arrayForKey("estados") as? [Bool] {
            
            if (estadosAtivos[indice]) {
                estadoCheckImageView.image = UIImage(named: "check_off")
                estadosAtivos[indice] = false
            } else {
                estadoCheckImageView.image = UIImage(named: "check")
                estadosAtivos[indice] = true
            }
            
            NSUserDefaults().setObject(estadosAtivos, forKey: "estados")
        }
    }

}
