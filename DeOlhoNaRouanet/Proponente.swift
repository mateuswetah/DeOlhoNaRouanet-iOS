//
//  Proponente.swift
//  DeOlhoNaRouanet
//
//  Created by Student on 12/1/16.
//  Copyright © 2016 Grupo: De Olho na Rouanet. All rights reserved.
//

import Foundation
import ObjectMapper

class Proponente: Mappable {
    
    // Informações utilizadas pelas View
    var nome:           String?
    var cgccpf:         String?
    var tipoPessoa:     String?
    var responsavel:    String?
    var UF:             String?
    var municipio:      String?
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        nome                <- map["nome"]
        cgccpf              <- map["cgccpf"]
        UF                  <- map["UF"]
        municipio           <- map["municipio"]
        responsavel         <- map["responsavel"]
        tipoPessoa          <- map["tipo_pessoa"]
    }
    
}