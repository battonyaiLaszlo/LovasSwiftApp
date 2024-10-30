//
//  CustomTableViewCell.swift
//  Lovas
//
//  Created by Battonyai-Fehér László on 11/07/2024.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    //ID
    public static let identifier = "CustomTableViewCell"
    
//MARK: CÍM, VÁROS, ÉRTÉKELÉS ÉS CONTAINER LÉTREHOZÁSA, LOVARDA ID TÁROLÁSA --------------------------------------------------------------
    
    var containerView: UIView =
    {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.lightBlue06.color
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    
    var title: UILabel =
    {
        var title = UILabel()
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 18)
        return title
    }()
    
    var secondaryTitle: UILabel =
    {
        var city = UILabel()
        city.textColor = .gray
        return city
    }()
    
    var rate: UILabel =
    {
        var rate = UILabel()
        rate.textColor = .gray
        return rate
    }()
    
    let arrow: UIImageView =
    {
        var arrow = UIImageView()
        arrow.tintColor = .lightGray
        return arrow
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: LABELEK FELHELYEZÉSE A CELLÁRA, CELLA BEÁLLÍTÁSA ------------------------------------------------------------------
    func setupUI()
    {
        contentView.addSubview(containerView)
        containerView.addSubview(title)
        containerView.addSubview(secondaryTitle)
        containerView.addSubview(rate)
        containerView.addSubview(arrow)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        secondaryTitle.translatesAutoresizingMaskIntoConstraints = false
        rate.translatesAutoresizingMaskIntoConstraints = false
        arrow.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                // feliratok elhelyezése
                title.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
                title.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),

                secondaryTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
                secondaryTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 0),
                
                arrow.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
                arrow.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                            
                rate.trailingAnchor.constraint(equalTo: arrow.trailingAnchor, constant: -30),
                rate.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                
                // cella méretezése
                containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
                containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
                containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
                containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
            ]
        )
    }
}
