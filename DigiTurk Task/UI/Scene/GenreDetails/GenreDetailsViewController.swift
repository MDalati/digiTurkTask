//
//  GenreDetailsViewController.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import UIKit

protocol GenreDetailsViewLogic {
    
    func displayInitializeResult(viewModel: GenreDetailsModels.Initialize.ViewModel)
    func displayReloadResult(viewModel: GenreDetailsModels.Reload.ViewModel)
    func displayOpenProgramResult(viewModel: GenreDetailsModels.OpenProgram.ViewModel)
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
    private var presentations: [ProgramCellPresentation] = []
    private var isLoading: Bool = false
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupCollectionView()
        interactor?.initialize(request: GenreDetailsModels.Initialize.Request())
    }
    
    private func setupCollectionView() {
        
        collectionView.register(cellType: ProgramCollectionViewCell.self)
        collectionView.register(cellType: LoadingFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter)
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = cellSpacing * 2
            flowLayout.minimumInteritemSpacing = cellSpacing
            flowLayout.scrollDirection = .vertical
            flowLayout.estimatedItemSize = .zero
        }
        collectionView.contentInset = collectionViewInsets
        collectionView.isPagingEnabled = false
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.reachedBottom && !isLoading {
            interactor?.reload(request: GenreDetailsModels.Reload.Request())
        }
    }
}

extension GenreDetailsViewController: GenreDetailsViewLogic {
    
    func displayInitializeResult(viewModel: GenreDetailsModels.Initialize.ViewModel) {
        
        self.presentations = viewModel.presentations
        collectionView.reloadData()
    }
    
    func displayReloadResult(viewModel: GenreDetailsModels.Reload.ViewModel) {
        
        self.isLoading = viewModel.isLoading
        let insertionStartIndex = self.presentations.count
        self.presentations.append(contentsOf: viewModel.newPagePresentations)
        
        collectionView.performBatchUpdates {
            
            collectionView.insertItems(at: viewModel.insertionIndexPathes)
        }
    }
    
    func displayOpenProgramResult(viewModel: GenreDetailsModels.OpenProgram.ViewModel) {
        
        router?.routeToPlayer(sender: self, for: viewModel.selectedProgram)
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.openProgram(request: GenreDetailsModels.OpenProgram.Request(index: indexPath.row))
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionFooter && isLoading {
            let footer: LoadingFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, for: indexPath)
            return footer
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if isLoading {
            return CGSize(width: collectionView.frame.width, height: 56)
        }
        return .zero
    }
}
