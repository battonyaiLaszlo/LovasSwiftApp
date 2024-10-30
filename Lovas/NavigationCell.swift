//
//  NavigationCollectionViewCell.swift
//  Lovas
//
//  Created by Battonyai-Fehér László on 19/07/2024.
//

import UIKit

class NavigationCell: UICollectionViewCell {
    
    var title: UILabel =
    {
        var title = UILabel()
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return title
    }()
    
    let arrow: UIImageView =
    {
        var arrow = UIImageView(image: UIImage(systemName: "chevron.right"))
        arrow.tintColor = .lightGray
        return arrow
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func setupViews() {
        contentView.addSubview(title)
        contentView.addSubview(arrow)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        arrow.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            arrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
        contentView.backgroundColor = Colors.otherLightBlue06.color
        contentView.layer.cornerRadius = 20
    }
}
