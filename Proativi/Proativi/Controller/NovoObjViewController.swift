//
//  ViewController.swift
//  Proativi
//
//  Created by Victor Falcetta do Nascimento on 22/01/20.
//  Copyright © 2020 Victor Falcetta do Nascimento. All rights reserved.
//

import UIKit

protocol NovoObjViewControllerDelegate: class {
    func addNovoObjViewControllerDidCancel (_ controller: NovoObjViewController)
    func addNovoObjViewController (_ controller: NovoObjViewController, didFinishAdding item: Objetivos)
}

class NovoObjViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    weak var delegate: NovoObjViewControllerDelegate?
    var prioridadeSelecionada: Int = 0
    
    @IBOutlet weak var pickerLembrete: UIDatePicker!
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var segmentPriori: UISegmentedControl!
    
    @IBAction func selectPriori(_ sender: Any) {
        switch segmentPriori.selectedSegmentIndex {
        case 0:
            segmentPriori.selectedSegmentTintColor = UIColor.init(cgColor: #colorLiteral(red: 0.6588235294, green: 0.8980392157, blue: 0.7137254902, alpha: 1))
            prioridadeSelecionada = 1
        case 1:
           segmentPriori.selectedSegmentTintColor = UIColor.init(cgColor: #colorLiteral(red: 0.8980392157, green: 0.831372549, blue: 0.6588235294, alpha: 1))
            prioridadeSelecionada = 2
        case 2:
            segmentPriori.selectedSegmentTintColor = UIColor.init(cgColor: #colorLiteral(red: 1, green: 0.6862745098, blue: 0.6862745098, alpha: 1))
            prioridadeSelecionada = 3
        default:
            break
        }
    }
    
    @IBAction func addNovoObj(_ sender: Any) {
        let novoObj = Objetivos(titulo: "", descricao: "", prioridade: 0, hora: "")
        if let fieldTituloObj = tituloTextField.text {
            novoObj.titulo = fieldTituloObj
        }
        if let fieldDescObj = descTextView.text {
            novoObj.descricao = fieldDescObj
        }
        novoObj.prioridade = prioridadeSelecionada
        
        pickerLembrete.datePickerMode = .time
        let date = pickerLembrete.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hora = components.hour
        let minuto = components.minute
        if minuto! < 10 {
            novoObj.hora = "\(hora!)h0\(minuto!)"
        } else {
            novoObj.hora = "\(hora!)h\(minuto!)"
        }
        
        delegate?.addNovoObjViewController(self, didFinishAdding: novoObj)
    }
    
    @IBAction func cancelNovoObj(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        delegate?.addNovoObjViewControllerDidCancel(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tituloTextField.delegate = self
        descTextView.delegate = self
        pickerLembrete.backgroundColor = UIColor.init(cgColor: #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1))
        // Do any additional setup after loading the view.
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
}

