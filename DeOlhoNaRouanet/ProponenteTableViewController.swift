//
//  ProponenteViewController.swift
//  DeOlhoNaRouanet
//
//  Created by Student on 11/30/16.
//  Copyright © 2016 Grupo: De Olho na Rouanet. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper


class ProponenteTableViewController: UITableViewController {
    
    // Received from Segue
    var nome: String = String()
    var cgccpf: String = String()
    
    // Data to be Loaded
    var proponente: Proponente = Proponente()
    
    // Outlets
    @IBOutlet weak var nomeProponenteLabel: UILabel!
    @IBOutlet weak var tipoPessoaLabel: UILabel!
    @IBOutlet weak var cgccpfTitleLabel: UILabel!
    @IBOutlet weak var cgccpfLabel: UILabel!
    @IBOutlet weak var responsavelTitleLabel: UILabel!
    @IBOutlet weak var responsavelLabel: UILabel!
    @IBOutlet weak var estadoTitleLabel: UILabel!
    @IBOutlet weak var estadoLabel: UILabel!
    @IBOutlet weak var municipioTitleLabel: UILabel!
    @IBOutlet weak var municipioLabel: UILabel!
    @IBOutlet weak var flagUFImageView: UIImageView!
    
    // Loading Spinner
    var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nomeProponenteLabel.text = ""
        tipoPessoaLabel.text = ""
        cgccpfTitleLabel.text = ""
        cgccpfLabel.text = ""
        responsavelTitleLabel.text = ""
        responsavelLabel.text = ""
        estadoTitleLabel.text = ""
        estadoLabel.text = ""
        municipioTitleLabel.text = ""
        municipioLabel.text = ""
        
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        activityIndicatorView.center = view.center
        
        view.addSubview(activityIndicatorView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear (animate: Bool) {
        super.viewWillAppear(animate)
        
        self.loadProponente()
    }
    
    // Download json and passes to object
    private func loadProponente () {
        
        // Sets the spinner view as background to the view
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        activityIndicatorView.startAnimating()
        
        // Download json and passes to object
        var URL = "http://hmg.api.salic.cultura.gov.br/beta/proponentes/?nome=" + self.nome
        URL = URL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        Alamofire.request(.GET, URL).responseJSON {
            response in
            
            switch response.result {
                
            case .Success:
                
                let proponenteResponse = response.result.value as? NSDictionary
                let proponentesResponseArray = proponenteResponse?.valueForKey("_embedded")!.valueForKey("proponentes")
                
                self.proponente = Mapper<Proponente>().mapArray(proponentesResponseArray!)![0]
                
                self.nomeProponenteLabel.text = self.proponente.nome!
                self.tipoPessoaLabel.text = "Pessoa " + self.proponente.tipoPessoa!
                self.cgccpfLabel.text = self.proponente.cgccpf!
                self.responsavelLabel.text = self.proponente.responsavel!
                self.estadoLabel.text = self.proponente.UF
                self.municipioLabel.text = self.proponente.municipio!
                self.flagUFImageView.image = UIImage(named: self.proponente.UF!)
                
                self.cgccpfTitleLabel.text = "CGCCPF"
                self.responsavelTitleLabel.text = "Responsável"
                self.estadoTitleLabel.text = "UF"
                self.municipioTitleLabel.text = "Município"
                
                self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            
            case .Failure:
                print("Error connecting to API")
            }
            
            self.activityIndicatorView.stopAnimating()
            
        }
    }
}
