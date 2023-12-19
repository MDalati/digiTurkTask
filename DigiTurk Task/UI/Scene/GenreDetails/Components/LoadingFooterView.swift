//
//  LoadingFooterView.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 20.12.2023.
//

import UIKit

class LoadingFooterView: UICollectionReusableView {
    
    // MARK: Views
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView()
        loadingView.style = .medium
        loadingView.color = .gray
        addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        return loadingView
    }()
    
    // MARK: View Lifecycle
    override func willMove(toSuperview newSuperview: UIView?) {
        
        super.willMove(toSuperview: newSuperview)
        loadingIndicator.startAnimating()
    }
}
