//
//  SituacaoTableViewController.swift
//  DeOlhoNaRouanet
//
//  Created by Student on 11/30/16.
//  Copyright © 2016 Grupo: De Olho na Rouanet. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class SituacaoTableViewController: UITableViewController {
    
    // Received from Segue
    var PRONAC: String = String()
    
    // Data to be Loaded
    var projeto: Projeto = Projeto()
    
    // Outlets declarations
    @IBOutlet weak var nomeProjetoLabel: UILabel!
    @IBOutlet weak var situacaoTextView: UITextView!
    @IBOutlet weak var providenciasTextView: UITextView!
    @IBOutlet weak var situacaoLabel: UILabel!
    @IBOutlet weak var providenciasLabel: UILabel!
    
    // Loading Spinner
    var activityIndicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nomeProjetoLabel.text = ""
        situacaoTextView.text = ""
        providenciasTextView.text = ""
        situacaoLabel.text = ""
        providenciasLabel.text = ""
        
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        activityIndicatorView.center = view.center
        
        view.addSubview(activityIndicatorView)
    
    }
    
    override func viewWillAppear (animate: Bool) {
        super.viewWillAppear(animate)
        
        self.loadProjeto()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Download json and passes to object
    private func loadProjeto() {
        
        // Sets the spinner view as background to the view
        activityIndicatorView.startAnimating()
        
        var URL = "http://hmg.api.salic.cultura.gov.br/beta/projetos/" + self.PRONAC
        URL = URL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        Alamofire.request(.GET, URL, parameters: nil, encoding: .JSON).responseJSON {
            response in
            
            switch response.result {
                
            case .Success:
                let projetoResponse = response.result.value as? NSDictionary
                self.projeto = Mapper<Projeto>().map(projetoResponse!)!
                
                self.nomeProjetoLabel.text = self.projeto.nome!
                self.situacaoTextView.text = self.projeto.situacao!
                self.providenciasTextView.text = self.projeto.providencia!
               
                self.situacaoLabel.text = "Situação"
                self.providenciasLabel.text = "Providências"
                
            case .Failure:
                print("Error connecting to API")
            }
            
            self.activityIndicatorView.stopAnimating()
            
        }
        
    }
    
    
}
