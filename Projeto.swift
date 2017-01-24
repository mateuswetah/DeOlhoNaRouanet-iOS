//
//  Projeto.swift
//  
//
//  Created by Student on 12/1/16.
//
//

import Foundation
import ObjectMapper

class Projeto: Mappable {
    
    // Informações utilizadas pelas View
    var nome:           String?
    var PRONAC:         String?
    var area:           String?
    var proponente:     String?
    var cgccpf:         String?
    var valorAprovado:   Int?
    var valorSolicitado: Int?
    var segmento:       String?
    var mecanismo:      String?
    var dataInicio:     String?
    var dataTermino:    String?
    var UF:             String?
    var municipio:      String?
    var situacao:       String?
    var providencia:    String?
    var resumo:         String?
    var objetivos:      String?
    var justificativa:  String?
    
    // Informações restantes provenientes da API
    //    var etapa:                  String
    //    var enquadramento:          String
    //    var fichaTecnica:           String
    //    var outrasFontes:           Int
    //    var acessibilidade:         String
    //    var sinopse:                String
    //    var estrategiaExecucao:     String
    //    var especificacaoTecnica:   String
    //    var impactoAmbiental:       String
    //    var democratizacao:         String
    //    var valorProjeto:           Int
    //    var anoProjeto:             String
    //    var valorCaptado:           Int
    //    var valorProposto:          Int
    
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    // Mappable
    func mapping(map: Map) {
        
        nome                <- map["nome"]
        PRONAC              <- map["PRONAC"]
        area                <- map["area"]
        proponente          <- map["proponente"]
        cgccpf              <- map["cgccpf"]
        valorAprovado       <- map["valor_aprovado"]
        valorSolicitado     <- map["valor_solicitado"]
        segmento            <- map["segmento"]
        mecanismo           <- map["mecanismo"]
        dataInicio          <- map["data_inicio"]
        dataTermino         <- map["data_termino"]
        UF                  <- map["UF"]
        municipio           <- map["municipio"]
        situacao            <- map["situacao"]
        providencia         <- map["providencia"]
        resumo              <- map["resumo"]
        objetivos           <- map["objetivos"]
        justificativa       <- map["justificativa"]
    }
    
    func obterNomeIconeArea() -> String {
        
        var nomeIcone: String = ""
        
        switch self.area! {
        case "Artes Cênicas":
            nomeIcone = "artes_cenicas"
        case "Audiovisual":
            nomeIcone = "audiovisual"
        case "Artes Integradas":
            nomeIcone = "artes_integradas"
        case "Música":
            nomeIcone = "musica"
        case "Artes Visuais":
            nomeIcone = "artes_visuais"
        case "Patrimônio Cultural":
            nomeIcone = "patrimonio_cultural"
        case "Humanidades":
            nomeIcone = "humanidades"
        default:
            nomeIcone = ""
        }
        
        return nomeIcone
    }

}
