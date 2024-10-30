//
//  Lovarda.swift
//  Lovas
//
//  Created by Battonyai-Fehér László on 28/06/2024.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseCore
import FirebaseStorage

public class Lovarda
{
    public let id: String
    public let name: String
    public let city: String
    public let fullAddress: String
    public let images: [String]
    public let rate: Double
    public let phone: String
    public let email: String
    public let area: Int
    public let boxNumber: Int
    public let fedeles: Int
    
    init?(document: QueryDocumentSnapshot)
    {
        let data = document.data()
        
        guard let id = document.documentID as? String,
              let name = data["name"] as? String,
              let city = data["city"] as? String,
              let fullAddress = data["fullAddress"] as? String,
              let images = data["images"] as? [String],
              let rate = data["rate"] as? Double,
              let phone = data["phone"] as? String,
              let email = data["email"] as? String,
              let area = data["area"] as? Int,
              let boxNumber = data["boxNumber"] as? Int,
              let fedeles = data["fedeles"] as? Int else { return nil }
        
        self.id = id
        self.name = name
        self.city = city
        self.fullAddress = fullAddress
        self.images = images
        self.rate = rate
        self.phone = phone
        self.email = email
        self.area = area
        self.boxNumber = boxNumber
        self.fedeles = fedeles
    }
    
    public static func Download() async throws -> [Lovarda]
    {
        let db = Firestore.firestore()
        var outArray: [Lovarda] = []
        let snapshot = try await db.collection("Lovardak").getDocuments()
        for document in snapshot.documents
        {
            let lovarda = Lovarda(document: document)!
            outArray.append(lovarda)
        }
        return outArray
    }
    
    public static func DownloadImages() async -> [UIImage]
    {
        var outArray: [UIImage] = []
        let storage = Storage.storage()
        let storageRef = storage.reference(forURL: "gs://lovas-38843.appspot.com/lovardaImages")
        var imageRef : StorageReference

        //print(DataStorage.shared.getLovarda()!.images)
        
        for imageLink in DataStorage.shared.getLovarda()!.images
        {
            imageRef = storageRef.child(imageLink)
            do 
            {
                let data = try await imageRef.data(maxSize: 2 * 1024 * 1024)
                outArray.append(UIImage(data: data)!)
            } catch {
                print("❌ - Downloading image")
            }
        }
        return outArray
    }
}


public class Location
{
    let name: String
    let latitude: Double;
    let longitude: Double;
    let lovardaID: String;
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let name = data["name"] as? String,
              let latitude = data["latitude"] as? Double,
              let longitude = data["longitude"] as? Double,
              let lovardaID = data["lovardaID"] as? String else {return nil}
        
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.lovardaID = lovardaID
    }
    
    public static func Download() async throws -> [Location]
    {
        let db = Firestore.firestore()
        var outArray: [Location] = []
        let snapshot = try await db.collection("Locations").getDocuments()
        for document in snapshot.documents
        {
            let location = Location(document: document)!
            outArray.append(location)
        }
        return outArray
    }
}
