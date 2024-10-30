//
//  LovardaInfoViewController.swift
//  Lovas
//
//  Created by Battonyai-Fehér László on 03/07/2024.
//

import UIKit

class LovardaInfoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
//MARK: VIEW DID LOAD -------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
//MARK: COLLECTION VIEW BEÁLLÍTÁSAI -------------------------------------------------------------------
    var collectionView: UICollectionView?
    func setupCollectionView() {
        
        let layout = createLayout()
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = Colors.lightBlue09.color
        registerCustomCells()
        
        // Hozzáadás a viewhoz
        view.addSubview(collectionView)
    }
    
//MARK: LAYOUT ELKÉSZÍTÉSE CELLÁKHOZ -------------------------------------------------------------------
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            var group: NSCollectionLayoutGroup
            var section: NSCollectionLayoutSection
            
            switch sectionIndex {
// 1. szakasz image slider
            case 0:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 0, bottom: 6, trailing: 0)
                group = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(0.4)
                    ),
                    subitems: [item]
                )
                section = NSCollectionLayoutSection(group: group)
// 2-6. szakasz: Lovarda név, kiegészítő szöveg
            case 1, 5:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)
                group = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(50)
                    ),
                    subitems: [item]
                )
                section = NSCollectionLayoutSection(group: group)
// 4-5 szakasz: Információ, Értékelés
            case 3, 4:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 6, trailing: 12)
                group = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(80)
                    ),
                    subitems: [item]
                )
                section = NSCollectionLayoutSection(group: group)
            case 2:
// 3. szakasz: két elem egymás mellett (Értékelés, város)
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .fractionalHeight(1.0)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)
                group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(52)
                    ),
                    subitems: [item]
                )
                section = NSCollectionLayoutSection(group: group)
            default:
                fatalError("❌ - Hibás szakasz!")
            }
            return section
        }
    }
    
// MARK: CELLÁK REGISZTRÁLÁSA
    func registerCustomCells()
    {
        guard let collectionView = collectionView else { return }
        
        collectionView.register(InfoCell.self, forCellWithReuseIdentifier: "infoCell")
        collectionView.register(LabelCell.self, forCellWithReuseIdentifier: "labelCell")
        collectionView.register(NavigationCell.self, forCellWithReuseIdentifier: "navigationCell")
        collectionView.register(ImageSliderCell.self, forCellWithReuseIdentifier: "imageSliderCell")
    }
    
// MARK: ADATOK CELLÁKHOZ RENDELÉSE ----------------------------------------------------
    
    // Szakaszok száma
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    // elemek száma szakaszonként
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 2 { return 2 }
        else if section == 0 && DataStorage.shared.getLovardaKepek().count == 0 { return 0 }
        return 1
    }
    // Cellák itemekhez rendelése és cellák egyéb beállításai
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let lovarda = DataStorage.shared.getLovarda()
        
        // Szakasz 2, 6
        if indexPath.section == 1 || indexPath.section == 5
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "labelCell", for: indexPath) as! LabelCell
            if indexPath.section == 1
            {
                cell.label.text = lovarda?.name
                cell.label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            } else {
                cell.label.text = "                További lehetőségek hamarosan" //TODO
                cell.label.textColor = Colors.paleBlue.color
            }

            return cell
        // Szakasz 3
        } else if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "infoCell", for: indexPath) as! InfoCell
            if indexPath.item == 0
            {
                cell.label.text = String(describing: (lovarda?.rate)!) + " ★"
                cell.label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
                if let rate = lovarda?.rate as? Double
                {
                    if rate >= 4 { cell.label.textColor = Colors.green.color }
                    else if rate >= 3.5 { cell.label.textColor = Colors.yellow.color }
                    else if rate >= 3 { cell.label.textColor = Colors.red.color }
                    else { cell.label.text = "- ★"}
                }
            } else {
                cell.label.text = lovarda?.city
            }
            return cell
        // Szakasz 4, 5
        } else if indexPath.section == 3 || indexPath.section == 4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "navigationCell", for: indexPath) as! NavigationCell
            if indexPath.section == 3 { cell.title.text = "Vélemények" }
            else {cell.title.text = "Információ" }
            return cell
        // Szakasz 1
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageSliderCell", for: indexPath) as! ImageSliderCell
            return cell
        }
    }
    
//MARK: VÉLEMÉNYEK / INFORMÁCIÓ MEGNYITÁSA
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
        var vc : UIViewController
        
        if indexPath.section == 3
        {
            vc = VelemenyekTableViewController()
            
        } else if indexPath.section == 4 {
            vc = InformacioTableViewController()
        } else { return }
        
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .fullScreen
        nc.modalTransitionStyle = .crossDissolve
        present(nc, animated: true)

    }
//MARK: VIEW DID DISAPPEAR
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("⚠️ - LOVARDA INFO: VIEW DID DISAPPEAR lefutott")
    }
    
//MARK: DEINIT
    deinit {
        print("⚠️ - LOVARDA INFO: DEINIT lefutott")
    }
}
