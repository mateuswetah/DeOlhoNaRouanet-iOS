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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
