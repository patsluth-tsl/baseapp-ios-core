//
//  FilePreviewer.swift
//  FilePreviewer
//
//  Created by Pat Sluth on 2017-12-08.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import AVKit
import Foundation

#if os(iOS)

import QuickLook
import UIKit

#endif

public enum FilePreviewer {
	public static func canPreview(fileURL: URL) -> Bool {
		return fileURL.isReachableFile && (fileURL.isPDFURL || fileURL.isVideoURL)
	}
	
	#if os(iOS)
	
    public static func preview<T: UIViewController>(
        from: T,
        initialIndexPath: IndexPath,
        forceLegacy: Bool = false
    ) where T: FilePreviewerDataSource & FilePreviewerDelegate {
		guard let initialFileURL = from.previewItem(at: initialIndexPath) as? URL else { return }
		
        guard !initialFileURL.isVideoURL else {
			let avPlayerViewController = AVPlayerViewController()
			
			avPlayerViewController.allowsPictureInPicturePlayback = true
			avPlayerViewController.updatesNowPlayingInfoCenter = false
			avPlayerViewController.player = AVPlayer(url: initialFileURL)
			avPlayerViewController.player?.allowsExternalPlayback = true
			avPlayerViewController.navigationController?.navigationBar.isHidden = true
			avPlayerViewController.navigationController?.toolbar.isHidden = true
			avPlayerViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
			
			from.present(avPlayerViewController, animated: true, completion: {
				avPlayerViewController.player?.play()
			})
			
			return
		}
        
		if #available(iOS 11.0, *), !forceLegacy {
			FilePreviewController.present(from: from, initialIndexPath: initialIndexPath)
		} else {
			let filePreviewController = FilePreviewControllerLegacy()
			filePreviewController.dataSource = from
			filePreviewController.delegate = from
			filePreviewController.section = initialIndexPath.section
			filePreviewController.currentPreviewItemIndex = initialIndexPath.item
			
			from.present(filePreviewController, animated: true, completion: nil)
		}
	}
	
	#endif
}


#if os(iOS)

public protocol FilePreviewerDataSource: QLPreviewControllerDataSource {
	func previewItem(at indexPath: IndexPath) -> QLPreviewItem
}

public protocol FilePreviewerDelegate: QLPreviewControllerDelegate {
//	func previewController<T>(_ controller: QLPreviewController,
//							  styleProviderType type: T.Type) -> UIBarStyleProvider?
//		where T: UINavigationBar
//	func previewController<T>(_ controller: QLPreviewController,
//							  styleProviderType type: T.Type) -> UIBarStyleProvider?
//		where T: UIToolbar
}

#endif
