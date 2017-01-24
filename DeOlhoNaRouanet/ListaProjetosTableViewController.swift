//
//  ListaProjetosTableViewController.swift
//  DeOlhoNaRouanet
//
//  Created by Student on 11/30/16.
//  Copyright © 2016 Grupo: De Olho na Rouanet. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class ListaProjetosTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {

    // Data to be Loaded
    var projetos: [Projeto] = [Projeto]()
    var projetosResultado: [Projeto] = [Projeto]()
    let apiURL: String = "http://hmg.api.salic.cultura.gov.br/beta/projetos/"
    var projetosCarregados = 0
    let projetosPorVez = 10
    var carregandoProjetos: Bool = false
    var areaSelecionada:Int = 0     // Toda as áreas
    var estadoSelecionado = "check" // Todos os estados
    var ordemSelecionada = ""
    var maxOffSetAtingido = false
    var searchQuery = ""
    var queryScope = 0
    
    //Cria o ActionSheet para listar modos de ordenação
    let actionSheetController: UIAlertController = UIAlertController(title: "Ordernar", message: "Escolha o campo pelo qual deseja ordenar a busca", preferredStyle: .ActionSheet)
    
    @IBAction func OrdenarButton(sender: AnyObject) {
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    // Loading Spinner
    var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "area")
        NSUserDefaults.standardUserDefaults().setObject("check", forKey: "estado")
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "filtered")
        
        configurarOrdenacao()
        
    }
    
    override func viewWillAppear (animate: Bool) {
        super.viewWillAppear(animate)
        
        areaSelecionada = NSUserDefaults().integerForKey("area")
        estadoSelecionado = NSUserDefaults().objectForKey("estado") as! String
        
        if (projetos.isEmpty || NSUserDefaults().boolForKey("filtered") == true) {
            self.projetos = [Projeto]()
            projetosCarregados = 0
            maxOffSetAtingido = false
            self.loadProjetos(apiURL + "?limit=" + String(projetosPorVez))
        }
        NSUserDefaults().setBool(false, forKey: "filtered")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.projetos.count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("listaProjetosCellIdentifier", forIndexPath: indexPath) as! ListaProjetosTableViewCell
        
        
        if (!self.projetos.isEmpty) {
            cell.nomeLabel.text = self.projetos[indexPath.row].nome
            cell.proponenteLabel.text = self.projetos[indexPath.row].proponente
            
            // Formatando valores em reais:
            let formatter = NSNumberFormatter()
            formatter.locale = NSLocale(localeIdentifier: "pt_BR")
            formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle;
            cell.valorSolicitadoLabel.text = formatter.stringFromNumber(self.projetos[indexPath.row].valorSolicitado!)
            
            cell.pronacLabel.text = self.projetos[indexPath.row].PRONAC!
            
            // Formatando a data em padrão dd/mm/aaaa
            cell.dataInicioLabel.text = "Data de Início"
            if let dataInicio = self.projetos[indexPath.row].dataInicio {
                let dateFormatterGet = NSDateFormatter()
                let dateFormatterSet = NSDateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd"
                dateFormatterSet.dateFormat = "dd/MM/yyyy"
                let date: NSDate? = dateFormatterGet.dateFromString(dataInicio)
                cell.dataInicioLabel.text = dateFormatterSet.stringFromDate(date!)
            }
            
            let nomeIcone = self.projetos[indexPath.row].obterNomeIconeArea()
            cell.categoriaImageView.image = UIImage(named: nomeIcone)
            
            projetosCarregados = projetosCarregados + 20

            // Alterna a cor de fund da célula
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
            } else {
                cell.backgroundColor = UIColor.whiteColor()
            }
            
            // See if we need to load more species
            let rowsToLoadFromBottom = 3;
            let rowsLoaded = projetos.count
            
            if (!self.carregandoProjetos && !maxOffSetAtingido && (indexPath.row >= (rowsLoaded - rowsToLoadFromBottom))) {
                self.loadProjetos(apiURL + "?limit=" + String(projetosPorVez) + "&offset=" + String(projetosCarregados))
                
            }
        }
        
        return cell
        
        
    }
    
    // Download json and passes to object
    private func loadProjetos (path: String) {
        
        // Sets the spinner view as background to the view
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.addSubview(activityIndicatorView)
        tableView.bringSubviewToFront(activityIndicatorView)
        activityIndicatorView.center = tableView.center
        activityIndicatorView.startAnimating()
        carregandoProjetos = true
        
        var URL = path
        
        // Add filters and order to the URL
        if (areaSelecionada > 0) {
            URL = URL + "&area=" + String(areaSelecionada)
        }
        if (estadoSelecionado != "check") {
            URL = URL + "&UF=" + estadoSelecionado
        }
        if(self.searchQuery != "") {
            if(queryScope == 0 ) {
                URL = URL + "&nome=" + self.searchQuery.lowercaseString
            } else {
                URL = URL + "&proponente=" + self.searchQuery.lowercaseString
            }
        }
        if (ordemSelecionada != "") {
            URL = URL + "&sort=" + ordemSelecionada + ":asc"
        }
        print(URL)
        URL = URL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        // Realizes the query to the API
        Alamofire.request(.GET, URL, parameters: nil, encoding: .JSON).responseJSON {
            response in
            
            switch response.result {
            
            case .Success:
                let projetoResponse = response.result.value as? NSDictionary
                if (projetoResponse?.valueForKey("message")) != nil {
                    print ("Nenhum projeto encontrado!")
                    
                    let noDataLabel: UILabel     = UILabel(frame: CGRectMake(0, 0, self.tableView.bounds.size.width, self.tableView.bounds.size.height))
                    noDataLabel.text             = "Nenhum projeto encontrado!"
                    noDataLabel.textColor        = UIColor.blackColor()
                    noDataLabel.textAlignment    = .Center
                    self.tableView.backgroundView = noDataLabel
                    self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
                    
                } else {
                    if let projetoResponseArray = projetoResponse?.valueForKey("_embedded")?.valueForKey("projetos") {
                    
                        let novosProjetos = Mapper<Projeto>().mapArray(projetoResponseArray)!
                
                        if (novosProjetos.count == 0) {
                            self.maxOffSetAtingido = true
                        }
                    
                        self.projetos.appendContentsOf(novosProjetos)
                        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
                    }
                }
                
                self.tableView.reloadData()
                
                
            case .Failure:
                print("Error connecting to API")
            
            }
            
            self.activityIndicatorView.stopAnimating()
            self.carregandoProjetos = false
            
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    
        if segue.identifier == "mostrarInfoDoProjeto" {
            
            if let projetoInfoViewController = segue.destinationViewController as? ProjetoInfoTableViewController {
                if let index = tableView.indexPathForSelectedRow {
                    let projeto = self.projetos[index.row]
                    
                    projetoInfoViewController.projeto = projeto
                    
                }
                
            }
        }
    }
    
    // ORDERNAÇÃO ---------------------------------------------------------------------------------------------
    func configurarOrdenacao() {
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancelar", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        
        //Create and add first option action
        let ordenarPorPronacAction: UIAlertAction = UIAlertAction(title: "PRONAC", style: .Default) { action -> Void in
            self.ordemSelecionada = "PRONAC"
            NSUserDefaults().setBool(true, forKey:"filtered");
            self.viewWillAppear(true)
        }
        actionSheetController.addAction(ordenarPorPronacAction)
        
        //Create and add a second option action
        let ordenarPorValorSolicitadoAction: UIAlertAction = UIAlertAction(title: "Valor Solicitado", style: .Default) { action -> Void in
            self.ordemSelecionada = "valor_solicitado"
            NSUserDefaults().setBool(true, forKey:"filtered");
            self.viewWillAppear(true)
        }
        actionSheetController.addAction(ordenarPorValorSolicitadoAction)
        
        //Create and add a second option action
        let ordenarPorDataInicioAction: UIAlertAction = UIAlertAction(title: "Data de Início", style: .Default) { action -> Void in
             self.ordemSelecionada = "data_inicio"
            NSUserDefaults().setBool(true, forKey:"filtered");
            self.viewWillAppear(true)
        }
        actionSheetController.addAction(ordenarPorDataInicioAction)
    }
    
    // PESQUISA -------------------------------------------------------------------------------------------------
  
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        if (searchBar.text!.isEmpty || searchBar.text == "") {
            searchQuery = ""
        } else {
            searchQuery = searchBar.text!
        }
        queryScope = searchBar.selectedScopeButtonIndex
        
        NSUserDefaults().setBool(true, forKey: "filtered")
        self.viewWillAppear(true)
    }
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {

        searchBarSearchButtonClicked(searchBar)
    }
}
