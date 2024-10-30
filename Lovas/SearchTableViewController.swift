//
//  SearchTableViewController.swift
//  Lovas
//
//  Created by Battonyai-Fehér László on 09/07/2024.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {

//MARK: VIEW DID LOAD ------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBarAndSearchBar()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        setupTableView()
        filteredLovardak = DataStorage.shared.getLovardaStorage()
        tableView.reloadData()
    }

//MARK: SETUP NAVBAR & SEARCHBAR ------------------------------------------------------------------
    func setupNavBarAndSearchBar()
    {
        //nav
        navigationItem.title = "Lovardák"
        let backButton = UIButton(type: .system)
        backButton.setTitle("Vissza", for: .normal)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(backBarButtonTapped), for: .touchUpInside)
        let backBarButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButton
        
        //search
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Keresés Lovardák között"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        filteredLovardak = DataStorage.shared.getLovardaStorage()
    }
    
    // Újraszűrés minden egyes gomb lenyomásakor
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty
        {
            filteredLovardak = DataStorage.shared.getLovardaStorage().filter
            {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.city.lowercased().contains(searchText.lowercased())
            }
        } else {
            filteredLovardak = DataStorage.shared.getLovardaStorage()
        }
        tableView.reloadData()
    }
    
    // Vissza gomb megnyomása
    @objc func backBarButtonTapped()
    {
        dismiss(animated: true, completion: nil)
    }
    
//MARK: TABLE VIEW BEÁLLÍTÁSA ------------------------------------------------------------------
    func setupTableView()
    {
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }
    
    // cella kiválasztásának beállítása
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        DataStorage.shared.setLovarda(lovarda: filteredLovardak[indexPath.row])
        let vc = TabBarController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        dismiss(animated: true) {
            NotificationCenter.default.post(name: .lovardaSelected, object: nil)
        }
    }

// MARK: TABLE VIEW DATA SOURCE ------------------------------------------------------------------
    // szekciók száma
    var filteredLovardak: [Lovarda] = []
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // sorok száma
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLovardak.count
    }
    // cella kialakítása
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = filteredLovardak[indexPath.row].name
            return cell
        }
        cell.selectionStyle = .none
        cell.title.text = filteredLovardak[indexPath.row].name
        cell.secondaryTitle.text = filteredLovardak[indexPath.row].city
        cell.rate.text = String(filteredLovardak[indexPath.row].rate) + " ★"
        cell.arrow.image = UIImage(systemName: "chevron.right")
        return cell
        
    }
    
//MARK: VIEW DID DISAPPEAR
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("⚠️ - SEARCH VIEW: VIEW DID DISAPPEAR lefutott")
    }
    
//MARK: DEINIT
    deinit {
        print("⚠️ - SEARCH VIEW: DEINIT lefutott")
    }
    
}


