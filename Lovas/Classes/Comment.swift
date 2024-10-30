//
//  File.swift
//  Lovas
//
//  Created by Battonyai-Fehér László on 28/06/2024.
//

import Foundation

public class Comment
{
    private let rate: Int
    private let comment: String
    private let lovardaID: String
    private let riderID: String
    
    init(rate: Int, comment: String, lovardaID: String, riderID: String) {
        self.rate = rate
        self.comment = comment
        self.lovardaID = lovardaID
        self.riderID = riderID
    }
    
    private func Send()
    {
        
    }
    
    private static func Download()
    {
        
    }
}
