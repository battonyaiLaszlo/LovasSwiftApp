//
//  InfoCollectionViewCell.swift
//  Lovas
//
//  Created by Battonyai-Fehér László on 19/07/2024.
//

import UIKit

class InfoCell: UICollectionViewCell 
{
    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        contentView.backgroundColor = Colors.otherLightBlue06.color
        contentView.layer.cornerRadius = 10
    }
}
