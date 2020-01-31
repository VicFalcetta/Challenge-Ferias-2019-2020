//
//  ObjtViewController.swift
//  Proativi
//
//  Created by Victor Falcetta do Nascimento on 23/01/20.
//  Copyright © 2020 Victor Falcetta do Nascimento. All rights reserved.
//

import UIKit

class ObjtViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var cView: UICollectionView!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var pendentesObj: UILabel!
    @IBOutlet weak var completosObj: UILabel!
    
    var completos = 0
    var pendentes: Int
    var objArray: [Objetivos]
    let objTest = Objetivos(titulo: "Fazer o app", descricao: "Conseguir terminar o app a tempo de entregar", prioridade: 3, hora: "19h30")
    
    let date = Date()
    let format = DateFormatter()
    let formattedDate: String

    
    required init?(coder: NSCoder) {
        self.objArray = []
        self.pendentes = 0
        
        self.format.dateFormat = "dd/MM/yyyy"
        self.formattedDate = format.string(from: date)
        
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objArray.append(objTest)
        pendentes = objArray.count
        
        pendentesObj.text = String(pendentes)
        completosObj.text = String(completos)
        data.text = formattedDate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pendentesObj.text = String(pendentes)
        completosObj.text = String(completos)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let objCell = collectionView.dequeueReusableCell(withReuseIdentifier: "objCell", for: indexPath) as! ObjCollectionViewCell
        
        if (objArray[indexPath.row].prioridade == 3) {
            objCell.objCorPriorit.backgroundColor = UIColor.init(cgColor: #colorLiteral(red: 1, green: 0.6862745098, blue: 0.6862745098, alpha: 1))
        } else if (objArray[indexPath.row].prioridade == 2) {
            objCell.objCorPriorit.backgroundColor = UIColor.init(cgColor: #colorLiteral(red: 0.8980392157, green: 0.831372549, blue: 0.6588235294, alpha: 1))
        } else {
            objCell.objCorPriorit.backgroundColor = UIColor.init(cgColor: #colorLiteral(red: 0.6588235294, green: 0.8980392157, blue: 0.7137254902, alpha: 1))
        }
        
        objCell.objTitulo.text = objArray[indexPath.row].titulo
        objCell.objHora.text = objArray[indexPath.row].hora
        
        objCell.layer.cornerRadius = 10.0
        objCell.layer.borderWidth = 0
        
        objCell.layer.shadowColor = UIColor.black.cgColor
        objCell.layer.shadowOffset = CGSize(width: 1, height: 4.0)
        objCell.layer.shadowOpacity = 0.30
        objCell.layer.masksToBounds = false
        objCell.layer.shadowPath = UIBezierPath(roundedRect: objCell.bounds, cornerRadius: objCell.contentView.layer.cornerRadius).cgPath
        
        return objCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detalheObjVC = storyboard?.instantiateViewController(withIdentifier: "DetalheObjViewController") as? DetalheObjViewController
        detalheObjVC?.titulo = objArray[indexPath.row].titulo
        detalheObjVC?.descricao = objArray[indexPath.row].descricao
        detalheObjVC?.onDelete = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.objArray.remove(at: indexPath.row)
            strongSelf.pendentes -= 1
            strongSelf.completos += 1
            strongSelf.cView.deleteItems(at: [indexPath])
        }
        guard let detalheVC = detalheObjVC else { return }
        self.navigationController?.pushViewController(detalheVC, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addObjSegue" {
            if let novoObjViewController = segue.destination as? NovoObjViewController {
                novoObjViewController.delegate = self
            }
        }
        
//        if segue.identifier == "detalheObj" {
//            guard let detalheVC = segue.destination as? DetalheObjViewController else { return }
//            let rowIndex = objArray.count - 1
//            let indexPath = IndexPath(row: rowIndex, section: 0)
//            print(indexPath.row)
//            detalheVC.titulo = objArray[indexPath.row].titulo
//            detalheVC.descricao = objArray[indexPath.row].descricao
//
//        }
    }
    
    @IBAction func didUnwindFromDetalheObj(_ sender: UIStoryboardSegue) {
        guard sender.source is DetalheObjViewController else { return }
    }

}

extension ObjtViewController: NovoObjViewControllerDelegate {
    func addNovoObjViewControllerDidCancel(_ controller: NovoObjViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addNovoObjViewController(_ controller: NovoObjViewController, didFinishAdding item: Objetivos) {
        navigationController?.popViewController(animated: true)
        let rowIndex = objArray.count
        objArray.append(item)
        let indexPath = IndexPath(row: rowIndex, section: 0)
        let indexPaths = [indexPath]
        cView.insertItems(at: indexPaths)
        pendentes += 1
    }
    
    
}
