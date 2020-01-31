//
//  NovaReflexViewController.swift
//  Proativi
//
//  Created by Victor Falcetta do Nascimento on 30/01/20.
//  Copyright © 2020 Victor Falcetta do Nascimento. All rights reserved.
//

import UIKit

protocol NovaReflexViewControllerDelegate: class {
    func addNovaReflexViewControllerDidCancel (_ controller: NovaReflexViewController)
    func addNovaReflexViewController (_ controller: NovaReflexViewController, didFinishAdding item: Reflexao)
}

class NovaReflexViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    weak var delegate: NovaReflexViewControllerDelegate?
    
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tituloTextField.delegate = self
        descTextView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelReflex(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        delegate?.addNovaReflexViewControllerDidCancel(self)
    }
    
    @IBAction func addReflex(_ sender: Any) {
        let novaReflex = Reflexao(titulo: "", descricao: "")
        if let tituloReflex = tituloTextField.text {
            novaReflex.titulo = tituloReflex
        }
        if let descReflex = descTextView.text {
            novaReflex.descricao = descReflex
        }
        delegate?.addNovaReflexViewController(self, didFinishAdding: novaReflex)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
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
