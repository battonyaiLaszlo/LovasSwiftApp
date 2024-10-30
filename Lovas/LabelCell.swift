//
//  LabelCollectionViewCell.swift
//  Lovas
//
//  Created by Battonyai-Fehér László on 19/07/2024.
//

import UIKit

class LabelCell: UICollectionViewCell {
    let label: UILabel = {
        let label = UILabel()

        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func setupViews() {
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
}
