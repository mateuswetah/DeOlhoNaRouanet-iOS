//
//  ListaProjetosTableViewCell.swift
//  DeOlhoNaRouanet
//
//  Created by Student on 11/30/16.
//  Copyright © 2016 Grupo: De Olho na Rouanet. All rights reserved.
//

import UIKit

class ListaProjetosTableViewCell: UITableViewCell {

    @IBOutlet weak var nomeLabel: UILabel!
    
    @IBOutlet weak var proponenteLabel: UILabel!
    
    @IBOutlet weak var valorSolicitadoLabel: UILabel!
    
    @IBOutlet weak var pronacLabel: UILabel!
    
    @IBOutlet weak var dataInicioLabel: UILabel!
    
    var categoriaIcone: String?
    @IBOutlet weak var categoriaImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
