//
//  ViewController.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import UIKit
import SnapKit

// MARK: - MainViewLogic

protocol MainViewLogic {
    
    func displayInitializeResult(viewModel: MainModels.Initialize.ViewModel)
    func displayReloadResult(viewModel: MainModels.Reload.ViewModel)
    func displayFinalizeResult(viewModel: MainModels.Finilize.ViewModel)
}

// MARK: - MainViewController

class MainViewController: UIViewController {
    
    // MARK: VIP
    var interactor: MainInteractorLogic?
    var router: MainRouterLogic?
    
    var datasource: MainDatasource? {
        return interactor as? MainDatasource
    }
    
    // MARK: Views
    private lazy var labelTitle: UILabel = {
       
        let label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: 36)
        label.textColor = .black
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview()
        }
        return label
    }()
    
    private lazy var viewPagerContainer: UIView = {
        
        let containerView = UIView(frame: .zero)
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(18)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        return containerView
    }()
    
    private lazy var pageViewController: UIPageViewController = {
       
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        addChild(pageViewController)
        viewPagerContainer.addSubview(pageViewController.view)
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        pageViewController.delegate = self
        pageViewController.dataSource = self
        return pageViewController
    }()
    
    private lazy var pageIndicator: UIPageControl = {
        let pageControl = UIPageControl(frame: .zero)
        pageControl.hidesForSinglePage = true
        pageControl.currentPageIndicatorTintColor = .blue
        pageControl.pageIndicatorTintColor = .black
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(24)
        }
        return pageControl
    }()
    
    // MARK: Variables
    private var genrePages: [MainModels.GenrePageModel] = [] {
        didSet {
            refresh()
        }
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        MainConfigurator.config(mainVC: self)
        interactor?.initialize(request: MainModels.Initialize.Request())
    }
    
    private func refresh() {
        
        var initViewControllers: [UIViewController] = []
        if let firstPage = genrePages.first {
            initViewControllers.append(firstPage.viewController)
        }
        pageViewController.setViewControllers(initViewControllers, direction: .forward, animated: false)
        labelTitle.text = genrePages.first?.title
        pageIndicator.numberOfPages = genrePages.count
        pageIndicator.currentPage = 0
    }
}

// MARK: - MainViewLogic

extension MainViewController: MainViewLogic {
    
    func displayInitializeResult(viewModel: MainModels.Initialize.ViewModel) {
        
        self.genrePages = viewModel.pages
    }
    
    func displayReloadResult(viewModel: MainModels.Reload.ViewModel) {
        
    }
    
    func displayFinalizeResult(viewModel: MainModels.Finilize.ViewModel) {
        
    }
}


// MARK: - UIPageViewControllerDelegate, UIPageViewControllerDelegate

extension MainViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = genrePages.firstIndex(where: {$0.viewController == viewController}) else {
            return nil
        }
        
        return genrePages[safe: currentIndex + 1]?.viewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = genrePages.firstIndex(where: {$0.viewController == viewController}) else {
            return nil
        }
        
        return genrePages[safe: currentIndex - 1]?.viewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let currentIndex = genrePages.firstIndex(where: {$0.viewController == pageViewController.viewControllers?.first}) else {
            return
        }
        labelTitle.text = genrePages[safe: currentIndex]?.title
        pageIndicator.currentPage = currentIndex
    }
    
}
