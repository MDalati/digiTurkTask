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
    
    private lazy var capsuleList: CapsuleList = {
        let capsuleList = CapsuleList(frame: .zero)
        view.addSubview(capsuleList)
        capsuleList.delegate = self
        capsuleList.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(12)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(56)
        }
        return capsuleList
    }()
    
    private lazy var viewPagerContainer: UIView = {
        
        let containerView = UIView(frame: .zero)
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(capsuleList.snp.bottom)
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
    }
}

// MARK: - MainViewLogic
extension MainViewController: MainViewLogic {
    
    func displayInitializeResult(viewModel: MainModels.Initialize.ViewModel) {
        
        self.genrePages = viewModel.pages
        capsuleList.cellPresentations = viewModel.capsuleListPresentations
        capsuleList.selectedIndex = 0
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
        
        guard let currentIndex = getCurrentPageIndex() else {
            return
        }
        updateSelectedPage(index: currentIndex)
    }
    
    private func updateSelectedPage(index: Int) {
        
        labelTitle.text = genrePages[safe: index]?.title
        capsuleList.selectedIndex = index
    }
    
    private func getCurrentPageIndex() -> Int? {
        
        return genrePages.firstIndex(where: {$0.viewController == pageViewController.viewControllers?.first})
    }
}

// MARK: - CapsuleListDelegate
extension MainViewController: CapsuleListDelegate {
    
    func capsuleList(_ sender: CapsuleList, didSelectItemAt index: Int) {
        
        guard let currentIndex = getCurrentPageIndex(), let targetPage = genrePages[safe: index] else {
            return
        }
        let direction: UIPageViewController.NavigationDirection = currentIndex < index ? .forward : .reverse
        pageViewController.setViewControllers([targetPage.viewController], direction: direction, animated: true)
        updateSelectedPage(index: index)
    }
}
