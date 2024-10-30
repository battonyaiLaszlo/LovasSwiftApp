//
//  VelemenyekTableViewController.swift
//  Lovas
//
//  Created by Battonyai-Fehér László on 01/08/2024.
//

import UIKit

class VelemenyekTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavbar()
    }
    
// MARK: SETUP NAVBAR
    func setupNavbar()
    {
        navigationItem.title = "Vélemények"

        let backButton = UIButton(type: .system)
        backButton.setTitle("Lovarda", for: .normal)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(backBarButtonTapped), for: .touchUpInside)
        let backBarButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButton
        
        let addButton = UIButton(type: .system)
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.tintColor = .black
        addButton.addTarget(self, action: #selector(addBarButtonTapped), for: .touchUpInside)
        let addBarButton = UIBarButtonItem(customView: addButton)
        navigationItem.rightBarButtonItem = addBarButton
    }
    
    @objc func backBarButtonTapped()
    {
        dismiss(animated: true)
    }
    
    @objc func addBarButtonTapped()
    {
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
}
