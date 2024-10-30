//
//  ImageSliderCollectionViewCell.swift
//  Lovas
//
//  Created by Battonyai-Fehér László on 19/07/2024.
//

import UIKit

class ImageSliderCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupCollectionView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: 330),
            contentView.heightAnchor.constraint(equalToConstant: self.frame.height),
            
            contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
// MARK: COLLECTION VIEW LÉTREHOZÁSA
    var collectionView: UICollectionView!
    func setupCollectionView()
    {
        let layout = createLayout()
        
        collectionView = UICollectionView(frame: contentView.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "imageCell")
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

// MARK: LAYOUT KIALAKÍTÁSA
    func createLayout() -> UICollectionViewLayout
    {
        return UICollectionViewCompositionalLayout {
            (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)))
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)),
                subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .paging
            
            return section
        }
    }

// MARK: COLLECTION VIEW DATA SOURCE
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataStorage.shared.getLovardaKepek().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCell
        cell.imageView.image = DataStorage.shared.getLovardaKepek()[indexPath.item]
        return cell
    }
}

// MARK: CONTENT VIEW-BAN LÉVŐ CUSTOM CELLA
class ImageCell: UICollectionViewCell
{
    var imageView: UIImageView = {
        let imageView = UIImageView()

        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView()
    {
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
    }
}
