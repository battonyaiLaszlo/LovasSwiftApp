//
//  CustomAnnotation.swift
//  Lovas
//
//  Created by Battonyai-Fehér László on 10/07/2024.
//

import UIKit
import MapKit

class CustomAnnotation: NSObject, MKAnnotation
{
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let lovardaID: String
    
    init(coordinate: CLLocationCoordinate2D, title: String?, lovardaID: String) {
        self.coordinate = coordinate
        self.title = title
        self.lovardaID = lovardaID
    }
}

