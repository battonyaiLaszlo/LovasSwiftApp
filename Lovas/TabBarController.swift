//
//  TabBarController.swift
//  Lovas
//
//  Created by Battonyai-Fehér László on 01/07/2024.
//

import UIKit

class TabBarController: UITabBarController {

// MARK: VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tabok létrehozása
        let first = UINavigationController(rootViewController: MapViewController())
        first.tabBarItem = UITabBarItem(title: "Térkép", image: UIImage(systemName: "map.fill"), tag: 0)
        let second = UINavigationController(rootViewController: ProfilViewController())
        second.tabBarItem = UITabBarItem(title: "Profil", image: UIImage(systemName: "person.fill"), tag: 1)
        
        // Tabok beállítása
        self.viewControllers = [first, second]
        
        // TabBar színeinek beállítása
        self.tabBar.backgroundColor = Colors.lightBlue09.color
        self.tabBar.tintColor = Colors.blue.color
        self.tabBar.unselectedItemTintColor = Colors.paleBlue.color
        
        // Tabbar formájának beállítása
        self.tabBar.layer.cornerRadius = 40
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //viewControllers = []
    }
}
