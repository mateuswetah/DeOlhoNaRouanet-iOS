	//
//  ProjetoInfoTableViewController.swift
//  DeOlhoNaRouanet
//
//  Created by Mateus Machado Luna on 09/01/17.
//  Copyright © 2017 Grupo: De Olho na Rouanet. All rights reserved.
//

import UIKit

class ProjetoInfoTableViewController: UITableViewController {

    // Data received from ListaProjetosTableViewController via segue
    var projeto: Projeto = Projeto()
    
    // Outlets declarations
    @IBOutlet weak var nomeDoProjetoLabel: UILabel!
    @IBOutlet weak var numeroPronacLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
   
    @IBOutlet weak var categoriaImageView: UIImageView!
    @IBOutlet weak var nomeProponenteLabel: UILabel!
    
    @IBOutlet weak var valorAprovadoLabel: UILabel!
    @IBOutlet weak var valorSolicitadoLabel: UILabel!
    
    @IBOutlet weak var segmentoLabel: UILabel!
    @IBOutlet weak var mecanismoLabel: UILabel!
    
    @IBOutlet weak var dataInicioLabel: UILabel!
    @IBOutlet weak var dataTerminoLabel: UILabel!
    
    @IBOutlet weak var UFLabel: UILabel!
    @IBOutlet weak var flagUFImageView: UIImageView!
    
    @IBOutlet weak var municipioLabel: UILabel!
    @IBOutlet weak var situaçãoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nomeDoProjetoLabel.text = projeto.nome
        numeroPronacLabel.text = "PRONAC: " + projeto.PRONAC!
        
        areaLabel.text = projeto.area
        categoriaImageView.image = UIImage(named: projeto.obterNomeIconeArea())
        nomeProponenteLabel.text = projeto.proponente
        
        // Formatando valores em reais:
        let formatter = NSNumberFormatter()
        formatter.locale = NSLocale(localeIdentifier: "pt_BR")
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle;
 
        valorAprovadoLabel.text = formatter.stringFromNumber(projeto.valorAprovado!)
        valorSolicitadoLabel.text = formatter.stringFromNumber(projeto.valorSolicitado!)
        
        segmentoLabel.text = projeto.segmento
        mecanismoLabel.text = projeto.mecanismo
        
        // Formatando a data em padrão dd/mm/aaaa
        let dateFormatterGet = NSDateFormatter()
        let dateFormatterSet = NSDateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        dateFormatterSet.dateFormat = "dd/MM/yyyy"
        
        dataInicioLabel.text = "Data de Início"
        if let dataInicioProjeto = self.projeto.dataInicio {
            let dataInicio: NSDate? = dateFormatterGet.dateFromString(dataInicioProjeto)
            dataInicioLabel.text = dateFormatterSet.stringFromDate(dataInicio!)
        }
        
        dataTerminoLabel.text = "Data de Término"
        if let dataTerminoProjeto = self.projeto.dataInicio {
            let dataTermino: NSDate? = dateFormatterGet.dateFromString(dataTerminoProjeto)
            dataTerminoLabel.text = dateFormatterSet.stringFromDate(dataTermino!)
        }
        
        UFLabel.text = projeto.UF
        flagUFImageView.image = UIImage(named: projeto.UF!)
        municipioLabel.text = projeto.municipio
        
        situaçãoLabel.text = projeto.situacao

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    
        if segue.identifier == "mostrarSituaçãoDoProjeto" {
            
            if let situacaoTableViewController = segue.destinationViewController as? SituacaoTableViewController {
                
                situacaoTableViewController.PRONAC = projeto.PRONAC!
            }
            
        } else if segue.identifier == "mostrarProponenteDoProjeto" {
            
            if let proponenteTableViewController = segue.destinationViewController as? ProponenteTableViewController {
                
                proponenteTableViewController.nome = projeto.proponente!
                proponenteTableViewController.cgccpf = projeto.cgccpf!

            }
        }
    
    }
    

}
