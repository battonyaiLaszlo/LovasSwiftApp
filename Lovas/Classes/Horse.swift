//
//  Horse.swift
//  Lovas
//
//  Created by Battonyai-Fehér László on 28/06/2024.
//

import Foundation
import UIKit

public class Horse
{
    private let name: String
    private let image: UIImage
    private let age: Int
    private let medicName: String
    private let medicNumber: String
    private let kovacsName: String
    private let kovacsNumber: String
    private let lovardaVezetoName: String
    private let lovardaVezetoNumber: String
    
    init(name: String, image: UIImage, age: Int, medicName: String, medicNumber: String, kovacsName: String, kovacsNumber: String, lovardaVezetoName: String, lovardaVezetoNumber: String) {
        self.name = name
        self.image = image
        self.age = age
        self.medicName = medicName
        self.medicNumber = medicNumber
        self.kovacsName = kovacsName
        self.kovacsNumber = kovacsNumber
        self.lovardaVezetoName = lovardaVezetoName
        self.lovardaVezetoNumber = lovardaVezetoNumber
    }
}
