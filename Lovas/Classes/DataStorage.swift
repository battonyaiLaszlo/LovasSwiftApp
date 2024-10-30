//
//  DataStorage.swift
//  Lovas
//
//  Created by Battonyai-Fehér László on 12/07/2024.
//

import Foundation
import UIKit

public class DataStorage
{
    public static let shared = DataStorage()
    
    private var lovardaStorage: [Lovarda] = []
    private var locationStorage: [Location] = []
    private var lovarda: Lovarda? = nil
    private var lovardaKepek: [UIImage] = []
    private var rider: Rider? = nil
    
    private init() {}
    
    public func getLovardaStorage() -> [Lovarda] { return lovardaStorage }
    public func setLovardaStrorage(lovardak: [Lovarda]) { lovardaStorage = lovardak }
    
    public func getLocationStorage() -> [Location] { return locationStorage }
    public func setLocationStorage(locations: [Location]) { locationStorage = locations }
    
    public func getLovarda() -> Lovarda? { return lovarda }
    public func setLovarda(lovarda: Lovarda?) { self.lovarda = lovarda }
    
    public func getRider() -> Rider? { return rider }
    public func setRider(rider: Rider) { self.rider = rider }
    
    public func getLovardaKepek() -> [UIImage] { return lovardaKepek }
    public func setLovardaKepek (images: [UIImage]) { self.lovardaKepek = images }
}
