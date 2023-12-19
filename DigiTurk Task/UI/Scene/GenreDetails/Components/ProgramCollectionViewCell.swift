//
//  ProgramCollectionViewCell.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import UIKit

struct ProgramCellPresentation {
    
    var id: Int?
    var title: String?
    var imageUrl: String?
}

class ProgramCollectionViewCell: UICollectionViewCell {
    
    // MARK: Views
    
    private lazy var imageCover: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        contentView.addSubview(imageView)
        imageView.roundCorners(with: 8)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(imageView.snp.width).multipliedBy(1.3)
        }
        return imageView
    }()
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
            make.top.equalTo(imageCover.snp.bottom).offset(8)
        }
        return label
    }()
    
    // MARK: Variables
    var presentation: ProgramCellPresentation? {
        didSet {
            setupUI()
        }
    }
    
    // MARK: Lifecycle
    
    override func didMoveToSuperview() {
        
        super.didMoveToSuperview()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    private func setupUI() {
        
        labelTitle.text = presentation?.title
        imageCover.loadImage(from: presentation?.imageUrl)
    }
    
}
