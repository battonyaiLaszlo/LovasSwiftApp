//
//  Rider.swift
//  Lovas
//
//  Created by Battonyai-Fehér László on 28/06/2024.
//

import Foundation
import UIKit

public class Rider
{
    private let id: String
    private var name: String
    private var image: UIImage
    private var lovardak: Lovarda
    private var horses : [Horse]
    
    init(id: String, name: String, image: UIImage, lovardak: Lovarda, horses: [Horse]) 
    {
        self.id = id
        self.name = name
        self.image = image
        self.lovardak = lovardak
        self.horses = horses
    }
    
    private func SetName(newName: String)
    {
        
    }
    
    private func SetImage()
    {
        
    }
    
    private func SetLovarda()
    {
        
    }
    
    private func AddNewHorse()
    {
        
    }
    
    private func RemoveHorse()
    {
        
    }
    
    private func EditHorse()
    {
        
    }
    
}
