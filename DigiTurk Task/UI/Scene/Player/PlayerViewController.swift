//
//  PlayerViewController.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 20.12.2023.
//

import UIKit
import AVKit

protocol PlayerViewLogic {
    
    func displayInitializeResult(viewModel: PlayerModels.Initialize.ViewModel)
}

class PlayerViewController: AVPlayerViewController {

    // MARK: VIP
    var interactor: PlayerInteractorLogic?
    var router: PlayerRouterLogic?
    var datasource: PlayerDatasource? {
        return interactor as? PlayerDatasource
    }
    
    // MARK: Views
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: 18)
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            make.leading.greaterThanOrEqualToSuperview().inset(18)
        }
        return label
    }()
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        interactor?.initialize(request: PlayerModels.Initialize.Request())
        startPlayer()
    }
    
    private func startPlayer() {
        guard  let url = datasource?.itemUrl else {
            return
        }
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
    }
}

// MARK: - PlayerViewLogic
extension PlayerViewController: PlayerViewLogic {
    
    func displayInitializeResult(viewModel: PlayerModels.Initialize.ViewModel) { }
}
