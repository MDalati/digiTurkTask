//
//  CapsuleList.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 20.12.2023.
//

import UIKit

protocol CapsuleListDelegate: AnyObject {
    
    func capsuleList(_ sender: CapsuleList, didSelectItemAt index: Int)
}

// MARK: - CapsuleList
class CapsuleList: UIView {

    // MARK: Views
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 10, height: 56)
        layout.minimumInteritemSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellType: CapsuleCollectionViewCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        addSubview(collectionView)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        return collectionView
    }()
    
    // MARK: Variables
    weak var delegate: CapsuleListDelegate?
    
    var selectedIndex: Int = 0 {
        didSet {
            updateSelectedIndex(oldIndex: oldValue, newIndex: selectedIndex)
        }
    }
    
    var cellPresentations: [CapsuleCellPresentation] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private func updateSelectedIndex(oldIndex: Int, newIndex: Int) {
        guard oldIndex != newIndex else {
            return
        }
        let oldIndexPath = IndexPath(row: oldIndex, section: 0)
        let newIndexPath = IndexPath(row: newIndex, section: 0)
        collectionView.reloadItems(at: [oldIndexPath, newIndexPath])
        collectionView.scrollToItem(
            at: IndexPath(row: newIndex, section: 0),
            at: .centeredHorizontally,
            animated: true
        )
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CapsuleList: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellPresentations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CapsuleCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        var presentation = cellPresentations[safe: indexPath.row]
        presentation?.isSelected = selectedIndex == indexPath.row
        cell.presentation = presentation
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.capsuleList(self, didSelectItemAt: indexPath.row)
    }
}
