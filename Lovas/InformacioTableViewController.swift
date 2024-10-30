//
//  InformacioTableViewController.swift
//  Lovas
//
//  Created by Battonyai-Fehér László on 01/08/2024.
//

import UIKit

class InformacioTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        setupTableView()
    }
    
// MARK: SETUP NAVBAR
    func setupNavbar()
    {
        navigationItem.title = "Információ"
        let backButton = UIButton(type: .system)
        backButton.setTitle("Lovarda", for: .normal)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(backBarButtonTapped), for:.touchUpInside)
        let backBarButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButton
    }
    
    @objc func backBarButtonTapped()
    {
        dismiss(animated: true, completion: nil)
    }

// MARK: - SETUP TABLE VIEW
    
    func setupTableView()
    {
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        }
        
        let lovarda = DataStorage.shared.getLovarda()
        switch indexPath.row
        {
        case 0:
            cell.title.text = "Név"
            cell.secondaryTitle.text = lovarda?.name
        case 1:
            cell.title.text = "Cím"
            cell.secondaryTitle.text = lovarda?.fullAddress
        case 2:
            cell.title.text = "Telefonszám"
            cell.secondaryTitle.text = lovarda?.phone
        case 3:
            cell.title.text = "E-mail cím"
            cell.secondaryTitle.text = lovarda?.email
        case 4:
            cell.title.text = "Lovarda területe"
            cell.secondaryTitle.text = "\((lovarda?.area)!) négyzetméter"
        case 5:
            cell.title.text = "Boxok száma"
            cell.secondaryTitle.text = "\((lovarda?.boxNumber)!) db"
        case 6:
            cell.title.text = "Fedeles"
            if (lovarda?.fedeles)! > 0 { cell.secondaryTitle.text = "Van"}
            else {cell.secondaryTitle.text = "Nincs" }
        default:
            cell.title.text = "-"
            cell.secondaryTitle.text = "-"
        }
        
        return cell
    }
}
