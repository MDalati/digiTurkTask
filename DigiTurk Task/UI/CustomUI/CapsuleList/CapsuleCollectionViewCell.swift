//
//  CapsuleCollectionViewCell.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 20.12.2023.
//

import UIKit

struct CapsuleCellPresentation {
    var title: String?
    var isSelected: Bool
}

class CapsuleCollectionViewCell: UICollectionViewCell {
 
    // MARK: Views
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel(frame: .zero)
        addSubview(label)
        label.textColor = .white
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(12)
            make.top.equalToSuperview().inset(8)
        }
        return label
    }()
    // MARK: Variables
    var presentation: CapsuleCellPresentation? {
        didSet {
            setupUI()
        }
    }
    
    private func setupUI() {
        
        contentView.backgroundColor = presentation?.isSelected == true ? .blue : .gray
        labelTitle.text = presentation?.title
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        contentView.roundedView()
    }
}
