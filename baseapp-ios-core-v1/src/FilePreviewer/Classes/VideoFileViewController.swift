//
//  VideoFileViewController.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-12-08.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

import AVKit
import Foundation
import UIKit

@available(iOS 11.0, *)
internal class VideoFileViewController: FileViewController {
    fileprivate var avPlayerViewController: AVPlayerViewController!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(
            nibName: "VideoFileViewController",
            bundle: FilePreviewer.resourceBundle()
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avPlayerViewController = AVPlayerViewController()
        
        avPlayerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        avPlayerViewController.view.backgroundColor = UIColor.clear
        avPlayerViewController.allowsPictureInPicturePlayback = true
        avPlayerViewController.showsPlaybackControls = true
        avPlayerViewController.updatesNowPlayingInfoCenter = false
        avPlayerViewController.entersFullScreenWhenPlaybackBegins = true
        avPlayerViewController.exitsFullScreenWhenPlaybackEnds = true
        //        self.avPlayerViewController.navigationController.navigationBar.hidden = YES
        //        self.avPlayerViewController.navigationController.toolbar.hidden = YES
        avPlayerViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        avPlayerViewController.willMove(toParent: self)
        addChild(avPlayerViewController)
        view.addSubview(avPlayerViewController.view)
        avPlayerViewController.didMove(toParent: self)
        
        avPlayerViewController.view.leadingAnchor
            .constraint(equalTo: view.safeLeadingAnchor)
            .isActive = true
        avPlayerViewController.view.trailingAnchor
            .constraint(equalTo: view.safeTrailingAnchor)
            .isActive = true
        avPlayerViewController.view.topAnchor
            .constraint(equalTo: view.safeTopAnchor)
            .isActive = true
        avPlayerViewController.view.bottomAnchor
            .constraint(equalTo: view.safeBottomAnchor)
            .isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        
        avPlayerViewController.player = nil
        
        guard let fileURL = self.fileURL else { return }
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        avPlayerViewController.player = AVPlayer(url: fileURL)
        avPlayerViewController.player?.allowsExternalPlayback = true
    }
}
