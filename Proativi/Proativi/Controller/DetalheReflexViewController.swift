//
//  DetalheReflexViewController.swift
//  Proativi
//
//  Created by Victor Falcetta do Nascimento on 30/01/20.
//  Copyright © 2020 Victor Falcetta do Nascimento. All rights reserved.
//

import UIKit

class DetalheReflexViewController: UIViewController {
    
    var titulo: String!
    var descricao: String!
    
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tituloLabel.text = titulo
        descLabel.text = descricao

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
