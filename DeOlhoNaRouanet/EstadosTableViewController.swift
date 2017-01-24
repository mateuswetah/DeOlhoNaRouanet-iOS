//
//  EstadosTableViewController.swift
//  DeOlhoNaRouanet
//
//  Created by Student on 11/30/16.
//  Copyright © 2016 Grupo: De Olho na Rouanet. All rights reserved.
//

import UIKit

class EstadosTableViewController: UITableViewController {

    // Data to be loaded
    var estados: [(nomeExtenso: String, sigla: String)] = Estados.getEstados()
    var estadosAtivos:[Bool] = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear (animate: Bool) {
        super.viewWillAppear(animate)
        
        self.estadosAtivos = (NSUserDefaults().arrayForKey("estados") as? [Bool])!
        print (estadosAtivos)
        
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.estados.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("estadosCellIdentifier", forIndexPath: indexPath) as! EstadosTableViewCell

            cell.nomeUFLabel.text = estados[indexPath.row].nomeExtenso
            let flagPath = estados[indexPath.row].sigla
            cell.flagImageView.image = UIImage(named: flagPath)
            cell.indice = indexPath.row
        
            if (estadosAtivos[indexPath.row]) {
                cell.estadoCheckImageView.image = UIImage(named: "check")
            } else {
                cell.estadoCheckImageView.image = UIImage(named: "check_off")
            }
        
        
        return cell
    }
    

}
