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

    var proponente: Proponente?
    var nome: String = ""
    var cgccpf: String = ""
    
    // Loading Spinner
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    var loadingView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadProponente () {
        
        self.showActivityIndicator()
        
        let URL = "http://hmg.api.salic.cultura.gov.br/beta/proponente/?cgccpf=" + self.cgccpf + "&nome=" + self.nome
        Alamofire.request(.GET, URL).responseJSON {
            response in
            
            let projetoResponse = response.result.value as? NSArray
            //print(projetoResponse![0])
            
            let proponentes = Mapper<Proponente>().mapArray(projetoResponse)!
            self.proponente = proponentes[0]
            
            self.hideActivityIndicator()
        }
    }
    
    // SPINNER --------------------------------------
    func showActivityIndicator() {
        dispatch_async(dispatch_get_main_queue()) {
            self.loadingView = UIView()
            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            self.loadingView.center = self.view.center
            self.loadingView.backgroundColor = UIColor.grayColor()
            self.loadingView.alpha = 0.5
            self.loadingView.clipsToBounds = true
            self.loadingView.layer.cornerRadius = 50
            
            self.spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)
            
            self.loadingView.addSubview(self.spinner)
            self.view.addSubview(self.loadingView)
            self.spinner.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        dispatch_async(dispatch_get_main_queue()) {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
