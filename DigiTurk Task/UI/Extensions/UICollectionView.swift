//
//  UICollectionView.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import UIKit

extension UICollectionView {
    
    func register(cellType: AnyClass) {
        let reuseId = String(describing: cellType.self)
        register(cellType, forCellWithReuseIdentifier: reuseId)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let reuseId = String(describing: T.self)
        return dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! T
    }
    
    func register(cellType: AnyClass, forSupplementaryViewOfKind kind: String) {
        let reuseId = String(describing: cellType.self)
        register(cellType, forSupplementaryViewOfKind: kind, withReuseIdentifier: reuseId)
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, for indexPath: IndexPath) -> T {
        let reuseId = String(describing: T.self)
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseId, for: indexPath) as! T
    }
}
