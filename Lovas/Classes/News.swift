//
//  News.swift
//  Lovas
//
//  Created by Battonyai-Fehér László on 28/06/2024.
//

import Foundation
import UIKit

public class News
{
    private let title: String
    private let main: String
    private let image: UIImage
    private let date: Date
    
    init(title: String, main: String, image: UIImage, date: Date) {
        self.title = title
        self.main = main
        self.image = image
        self.date = date
    }
    
    private static func Download()
    {
        
    }
}
