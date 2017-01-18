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

class ListaProjetosTableViewController: UITableViewController 	{

    // Data to be Loaded
    var projetos: [Projeto] = [Projeto]()
    
    // Loading Spinner
    var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        tableView.backgroundView = activityIndicatorView
    
    }
    
    override func viewWillAppear (animate: Bool) {
        super.viewWillAppear(animate)
        
        if (projetos.isEmpty) {
            self.loadProjetos()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.projetos.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("listaProjetosCellIdentifier", forIndexPath: indexPath) as! ListaProjetosTableViewCell

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

        return cell
    }
    
    // Download json and passes to object
    private func loadProjetos () {
        
        // Sets the spinner view as background to the view
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        activityIndicatorView.startAnimating()
        
        
        // Realizes the query to the API
        var URL = "http://hmg.api.salic.cultura.gov.br/beta/projetos/"
        URL = URL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        Alamofire.request(.GET, URL, parameters: nil, encoding: .JSON).responseJSON {
            response in
            
            switch response.result {
            
            case .Success:
                let projetoResponse = response.result.value as? NSDictionary
                let projetoResponseArray = projetoResponse?.valueForKey("_embedded")!.valueForKey("projetos")
                
                self.projetos = Mapper<Projeto>().mapArray(projetoResponseArray!)!
                self.tableView.reloadData()
                self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
                
            case .Failure:
                print("Error connecting to API")
            
            }
            
            self.activityIndicatorView.stopAnimating()
            
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
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
    

}
