//
//  ReflexaoViewController.swift
//  Proativi
//
//  Created by Victor Falcetta do Nascimento on 30/01/20.
//  Copyright © 2020 Victor Falcetta do Nascimento. All rights reserved.
//

import UIKit
import CoreData

class ReflexaoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectView: UICollectionView!
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var reflexArray: [Reflexion]
    let date = Date()
    let format = DateFormatter()
    let formattedDate: String
    
    required init?(coder: NSCoder) {
        reflexArray = []
        self.format.dateFormat = "dd/MM/yyyy"
        self.formattedDate = format.string(from: date)
        
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            reflexArray = try context.fetch(Reflexion.fetchRequest())
        } catch let error as NSError {
            print("Não foi possivel buscar o dado. \(error), \(error.userInfo)")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reflexArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let rflxCell = collectionView.dequeueReusableCell(withReuseIdentifier: "reflexCell", for: indexPath) as! ReflexCollectionViewCell
        
        rflxCell.dataLabel.text = formattedDate
        rflxCell.tituloLabel.text = reflexArray[indexPath.row].titulo
        
        rflxCell.layer.cornerRadius = 10.0
        rflxCell.layer.borderWidth = 0
        
        rflxCell.layer.shadowColor = UIColor.black.cgColor
        rflxCell.layer.shadowOffset = CGSize(width: 1, height: 4.0)
        rflxCell.layer.shadowOpacity = 0.30
        rflxCell.layer.masksToBounds = false
        rflxCell.layer.shadowPath = UIBezierPath(roundedRect: rflxCell.bounds, cornerRadius: rflxCell.contentView.layer.cornerRadius).cgPath
        
        return rflxCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detalheReflexVC = storyboard?.instantiateViewController(withIdentifier: "DetalheReflexViewController") as? DetalheReflexViewController
        detalheReflexVC?.titulo = reflexArray[indexPath.row].titulo
        detalheReflexVC?.descricao = reflexArray[indexPath.row].descricao
        guard let detalheVC = detalheReflexVC else { return }
        self.navigationController?.pushViewController(detalheVC, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addReflex" {
            if let novaReflexViewController = segue.destination as? NovaReflexViewController {
                novaReflexViewController.delegate = self
            }
        }
    }

}

extension ReflexaoViewController: NovaReflexViewControllerDelegate {
    
    func addNovaReflexViewController(_ controller: NovaReflexViewController, didFinishAdding item: Reflexion) {
        navigationController?.popViewController(animated: true)
        let rowIndex = reflexArray.count
        reflexArray.append(item)
        let indexPath = IndexPath(row: rowIndex, section: 0)
        let indexPaths = [indexPath]
        collectView.insertItems(at: indexPaths)
    }
    
//    func addNovoObjViewController(_ controller: NovoObjViewController, didFinishAdding item: Objetivos) {
//        navigationController?.popViewController(animated: true)
//        let rowIndex = objArray.count
//        objArray.append(item)
//        let indexPath = IndexPath(row: rowIndex, section: 0)
//        let indexPaths = [indexPath]
//        cView.insertItems(at: indexPaths)
//    }

    func addNovaReflexViewControllerDidCancel(_ controller: NovaReflexViewController) {
        navigationController?.popViewController(animated: true)
    }
    
}
