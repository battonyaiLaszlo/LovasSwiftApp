//
//  Colors.swift
//  Lovas
//
//  Created by Battonyai-Fehér László on 22/07/2024.
//

import Foundation
import UIKit

enum Colors
{
    case lightBlue09
    case lightBlue06
    case lightBlue10
    case otherLightBlue06
    case blue
    case paleBlue
    case green
    case yellow
    case red
    
    var color: UIColor
    {
        switch self
        {
            case .lightBlue09 : return UIColor(red: 200/255, green: 238/255, blue: 255/255, alpha: 0.9)
            case .lightBlue06 : return UIColor(red: 200/255, green: 238/255, blue: 255/255, alpha: 0.6)
            case .lightBlue10 : return UIColor(red: 200/255, green: 238/255, blue: 255/255, alpha: 1)
            case .otherLightBlue06 : return UIColor(red: 145/255, green: 217/255, blue: 249/255, alpha: 0.6)
            case .blue : return UIColor(red: 18/255, green: 94/255, blue: 240/255, alpha: 1)
            case .paleBlue : return UIColor(red: 131/255, green: 163/255, blue: 226/255, alpha: 1)
            case .green : return UIColor(red: 0, green: 128/255, blue: 0, alpha: 1)
            case .yellow : return UIColor(red: 172/255, green: 166/255, blue: 26/255, alpha: 1)
            case .red : return UIColor(red: 172/255, green: 43/255, blue: 26/255, alpha: 1)
        }
    }
}
