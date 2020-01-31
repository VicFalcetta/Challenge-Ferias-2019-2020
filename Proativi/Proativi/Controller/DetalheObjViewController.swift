//
//  DetalheObjViewController.swift
//  Proativi
//
//  Created by Victor Falcetta do Nascimento on 29/01/20.
//  Copyright © 2020 Victor Falcetta do Nascimento. All rights reserved.
//

import UIKit

class DetalheObjViewController: UIViewController {
    var onDelete: (() -> Void)?

    var timer = Timer()
    var tempo = 1800
    var isDescanso = false
    var isCorrendoCrono = false
    var ciclosTrabs = 0
    
    @IBOutlet weak var tituloObj: UILabel!
    @IBOutlet weak var descObj: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var ciclosLabel: UILabel!
    
    @IBOutlet weak var botaoTimer: UIButton!
    @IBOutlet weak var botaoFim: UIButton!
    
    var titulo: String!
    var descricao: String!
    
    @IBAction func iniciarTimer(_ sender: Any) {
        if isCorrendoCrono == false {
            updateTimer()
            isCorrendoCrono = true
        }
        botaoTimer.backgroundColor = UIColor.gray
    }
    @IBAction func finalizarObj(_ sender: Any) {
        onDelete?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tituloObj.text = titulo
        descObj.text = descricao
        
        botaoTimer.layer.cornerRadius = 10.0
        botaoTimer.layer.borderWidth = 1.0
        botaoTimer.layer.borderColor = UIColor.clear.cgColor
        
        botaoFim.layer.cornerRadius = 10.0
        botaoFim.layer.borderWidth = 1.0
        botaoFim.layer.borderColor = UIColor.clear.cgColor
        botaoFim.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    func updateTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (_) in
            guard let strongSelf = self else { return }
            
            strongSelf.tempo -= 1
            let minuto: Int = strongSelf.tempo / 60
            let segundo: Int = strongSelf.tempo % 60
            if minuto < 10 {
                if segundo > 10 {
                    strongSelf.timerLabel.text = "0\(minuto) : \(segundo)"
                } else {
                    strongSelf.timerLabel.text = "0\(minuto) : 0\(segundo)"
                }
            } else {
                if segundo > 10 {
                    strongSelf.timerLabel.text = "\(minuto) : \(segundo)"
                } else {
                    strongSelf.timerLabel.text = "\(minuto) : 0\(segundo)"
                }
            }
            if strongSelf.isDescanso == false {
                if strongSelf.tempo <= 0 {
                    strongSelf.isCorrendoCrono = false
                    strongSelf.timer.invalidate()
                    strongSelf.botaoTimer.backgroundColor = UIColor.init(cgColor: #colorLiteral(red: 0.4726880414, green: 0.764504327, blue: 0.6481486494, alpha: 1))
                    strongSelf.botaoTimer.setTitle("Descansar", for: .normal)
                    strongSelf.tempo = 300
                    strongSelf.isDescanso = true
                    strongSelf.ciclosTrabs += 1
                    strongSelf.ciclosLabel.text = String(strongSelf.ciclosTrabs)
                    strongSelf.botaoFim.isHidden = false
                }
            } else {
                if strongSelf.tempo <= 0 {
                    strongSelf.isCorrendoCrono = false
                    strongSelf.timer.invalidate()
                    strongSelf.botaoTimer.backgroundColor = UIColor.init(cgColor: #colorLiteral(red: 0.3843137255, green: 0.4901960784, blue: 0.6901960784, alpha: 1))
                    strongSelf.botaoTimer.setTitle("Trabalhar", for: .normal)
                    strongSelf.tempo = 1800
                    strongSelf.isDescanso = false
                    strongSelf.botaoFim.isHidden = true
                }
            }
            
        })
    }
}
