//
//  GenreDetailsViewController.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import UIKit

protocol GenreDetailsViewLogic {
    
    func displayInitializeResult(viewModel: GenreDetailsModels.Initialize.ViewModel)
}

class GenreDetailsViewController: UICollectionViewController {
    
    // MARK: VIP
    
    var interactor: GenreDetailsInteractorLogic?
    var router: GenreDetailsRouterLogic?
    
    // MARK: Views
    
    // MARK: Variables
    private let cellSpacing: CGFloat = 16
    private let collectionViewInsets = UIEdgeInsets(top: 18, left: 18, bottom: 56, right: 18)
    private let numberOfItemsInRow: CGFloat = 2
    private var presentations: [ProgramCellPresentation] = [] {
        didSet {
            collectionView.layoutIfNeeded()
            collectionView.reloadData()
        }
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupCollectionView()
        interactor?.initialize(request: GenreDetailsModels.Initialize.Request())
    }
    
    private func setupCollectionView() {
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = cellSpacing * 2
            flowLayout.minimumInteritemSpacing = cellSpacing
            flowLayout.sectionInset = collectionViewInsets
            flowLayout.scrollDirection = .vertical
            flowLayout.estimatedItemSize = .zero
        }
        collectionView.isPagingEnabled = false
        collectionView.register(cellType: ProgramCollectionViewCell.self)
    }
}

extension GenreDetailsViewController: GenreDetailsViewLogic {
    
    func displayInitializeResult(viewModel: GenreDetailsModels.Initialize.ViewModel) {
        
        self.presentations = viewModel.presentations
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDatasource, UICollectionViewDelegateFlowLayout

extension GenreDetailsViewController: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return presentations.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ProgramCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.presentation = presentations[safe: indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let availableWidth = collectionView.frame.width - ((numberOfItemsInRow - 1) * cellSpacing) - (collectionViewInsets.left + collectionViewInsets.right)
        let itemWidth = availableWidth/numberOfItemsInRow
        return CGSize(width: itemWidth, height: 250)
    }
}
