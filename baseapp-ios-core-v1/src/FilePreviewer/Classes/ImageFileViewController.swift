//
//  ImageFileViewController.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-12-08.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

import AVKit
import Foundation
import Kingfisher
import UIKit

@available(iOS 11.0, *)
internal class ImageFileViewController: FileViewController {
    @IBOutlet private var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
        }
    }
    @IBOutlet private var imageView: UIImageView! {
        didSet {
            imageView.kf.indicatorType = .activity
//            (imageView.kf.indicator?.view as? UIActivityIndicatorView)?.color = UIColor.main
        }
    }
    @IBOutlet private var errorLabel: UILabel!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(
            nibName: "ImageFileViewController",
            bundle: FilePreviewer.resourceBundle()
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = nil
        errorLabel.text = nil
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.onDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        
        imageView.image = nil
        errorLabel.text = nil
        imageView.kf.indicator?.startAnimatingView()
        ThumbnailGenerator.shared
            .generate(
                for: fileURL,
                usingCache: true)
            .done({ [weak self] in
                self?.imageView.image = $0
            })
            .catch({ [weak self] in
                self?.imageView.image = nil
                self?.errorLabel.text = "\($0)"
                logger.log(error: $0)
            })
            .finally({ [weak self] in
                self?.imageView.kf.indicator?.stopAnimatingView()
                self?.updateZoomScale()
            })
    }
}


// MARK: - Private Instance Methods
@available(iOS 11.0, *)
private extension ImageFileViewController {
    func updateZoomScale() {
        scrollView.minimumZoomScale = min(
            scrollView.bounds.width / imageView.bounds.width,
            scrollView.bounds.height / imageView.bounds.height
        )
        scrollView.maximumZoomScale = 6.0
        scrollView.zoomScale = 1.0
    }
    
    @objc func onDoubleTap(_ tap: UITapGestureRecognizer) {
        scrollView.setZoomScale(1.0, animated: true)
    }
}


@available(iOS 11.0, *)
extension ImageFileViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
