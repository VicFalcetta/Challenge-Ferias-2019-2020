//
//  Objetivos.swift
//  Proativi
//
//  Created by Victor Falcetta do Nascimento on 23/01/20.
//  Copyright © 2020 Victor Falcetta do Nascimento. All rights reserved.
//

import Foundation

class Objetivos {
    var titulo: String
    var descricao: String
    var prioridade: Int
    var hora: String
    
    init(titulo: String, descricao: String, prioridade: Int, hora: String) {
        self.titulo = titulo
        self.descricao = descricao
        self.prioridade = prioridade
        self.hora = hora
    }
}
