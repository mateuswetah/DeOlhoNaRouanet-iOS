//
//  FiltrosViewController.swift
//  DeOlhoNaRouanet
//
//  Created by Student on 11/30/16.
//  Copyright © 2016 Grupo: De Olho na Rouanet. All rights reserved.
//

import UIKit

class FiltrosTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var areaPickerView: UIPickerView!
    let areas:[String] = ["Todas as áreas",
                          "Artes Cênicas",
                          "Audiovisual",
                          "Música",
                          "Artes Visuais",
                          "Patrimônio cultural",
                          "Humanidades",
                          "Artes Integradas"]
    let areasIcones:[String] = ["check",
                          "artes_cenicas",
                          "audiovisual",
                          "musica",
                          "artes_visuais",
                          "patrimonio_cultural",
                          "humanidades",
                          "artes_integradas"]
    
    @IBOutlet weak var estadosPicekrView: UIPickerView!
    var estados:[(nomeExtenso: String, sigla: String)] = Estados.getEstados()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        estados.insert(("Todos os estados", "check"), atIndex: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear (animate: Bool) {
        super.viewWillAppear(animate)
        
        areaPickerView.selectRow(NSUserDefaults().integerForKey("area"), inComponent: 0, animated: true)
        
        let estadoSelecionado:String = NSUserDefaults().objectForKey("estado") as! String
        var indiceEstado = 0
        for indice in 0...self.estados.count - 1 {
            if (estadoSelecionado == self.estados[indice].sigla) {
                indiceEstado = indice
            }
        }
        estadosPicekrView.selectRow(indiceEstado, inComponent: 0, animated: true)
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(tableView: UITableView,
                            didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (pickerView == areaPickerView) {
            return areas[row]
        } else {
            return estados[row].nomeExtenso
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == areaPickerView) {
            return areas.count
        } else {
            return estados.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (pickerView == areaPickerView) {
            NSUserDefaults().setInteger(row, forKey: "area" )
        } else {
            NSUserDefaults().setObject(estados[row].sigla, forKey: "estado")
        }
        
        NSUserDefaults().setBool(true, forKey: "filtered")
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        let myView = UIView(frame: CGRectMake(0, 0, pickerView.bounds.width - 180, 60))
        
        if (pickerView == areaPickerView) {
            let myImageView = UIImageView(frame: CGRectMake(0, 20, 22, 22))
            myImageView.image = UIImage(named: areasIcones[row])
                var rowString = String()
            rowString = areas[row]
        
            let myLabel = UILabel(frame: CGRectMake(40, 0, pickerView.bounds.width - 20, 60 ))
            myLabel.text = rowString
        
            myView.addSubview(myLabel)
            myView.addSubview(myImageView)
            
        } else {
            var myImageView: UIImageView
            if (row == 0) {
                myImageView = UIImageView(frame: CGRectMake(0, 20, 22, 22))
            } else {
                myImageView = UIImageView(frame: CGRectMake(0, 20, 33, 22))
            }
            myImageView.image = UIImage(named: estados[row].sigla)
            var rowString = String()
            rowString = estados[row].nomeExtenso
            
            let myLabel = UILabel(frame: CGRectMake(40, 0, pickerView.bounds.width - 20, 60 ))
            myLabel.text = rowString
            
            myView.addSubview(myLabel)
            myView.addSubview(myImageView)
        }
        
        return myView
    }
    

}
