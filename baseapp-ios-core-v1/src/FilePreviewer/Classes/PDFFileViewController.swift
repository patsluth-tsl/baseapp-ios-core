//
//  PDFFileViewController.swift
//  FilePreviewer
//
//  Created by Pat Sluth on 2017-12-08.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation
import PDFKit
import QuickLook
import UIKit

@available(iOS 11.0, *)
internal class PDFFileViewController: FileViewController {
	private var pdfView: PDFView!
	@IBOutlet private var pageIndicatorView: PDFPageIndicatorView!
	@IBOutlet private var pageSelectionView: PDFPageSelectionView!
	
	@IBOutlet private var pageSelectionViewTrailingConstraint: NSLayoutConstraint!
    
    
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(
            nibName: "PDFFileViewController",
            bundle: FilePreviewer.resourceBundle()
        )
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
		pdfView = PDFView()
		pdfView.translatesAutoresizingMaskIntoConstraints = false
//		pdfView.clipsToBounds = false
//		pdfView.scrollView?.clipsToBounds = false
//		pdfView.scrollView?.contentInset = UIEdgeInsets(top: 50.0,
//															 left: 10.0,
//															 bottom: 50.0,
//															 right: 10.0)
		pdfView.displayMode = PDFDisplayMode.singlePageContinuous
		pdfView.autoScales = true
		pdfView.scrollView?.alwaysBounceVertical = true
		view.addSubview(pdfView)
		view.sendSubviewToBack(pdfView)
		
		
		
		pdfView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor).isActive = true
		pdfView.trailingAnchor.constraint(equalTo: pageSelectionView.leadingAnchor).isActive = true
		pdfView.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
		pdfView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive = true
		
		
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(self.onTap(_:)))
		pdfView.addGestureRecognizer(tap)
		
		let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.onDoubleTap(_:)))
		doubleTap.numberOfTapsRequired = 2
		pdfView.addGestureRecognizer(doubleTap)
		tap.require(toFail: doubleTap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
		
		updateForNavigationBars(false)
    }
	
    override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		view.setNeedsLayout()
		view.layoutIfNeeded()
		
		pdfView.scaleToFit(true)
	}
	
    override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
	}
	
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        
		defer {
			pageIndicatorView.pdfView = pdfView
			pageSelectionView.pdfView = pdfView
			pdfView.scrollView?.contentOffset = CGPoint.zero
		}
		
        loadViewIfNeeded()
        pdfView.document = nil
		pdfView.autoScales = true
		
		pageSelectionView.isHidden = false
		
		guard let fileURL = self.fileURL else { return }
		
		view.setNeedsLayout()
		view.layoutIfNeeded()
		
		pdfView.document = fileURL.pdfDocument
        updateForNavigationBars(false)
	}
	
//	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
//	{
//		super.viewWillTransition(to: size, with: coordinator)
//
//		print(self.pdfView.scaleFactorForSizeToFit)
//
//		coordinator.animate(alongsideTransition: { (context: UIViewControllerTransitionCoordinatorContext) in
//
//		}) { (context: UIViewControllerTransitionCoordinatorContext) in
//			print(self.pdfView.scaleFactorForSizeToFit)
//		}
//	}
}

@available(iOS 11.0, *)
private extension PDFFileViewController {
    func updateForNavigationBars(_ animated: Bool) {
        let navigationBarsHidden: Bool
        if let nc = navigationController {
            navigationBarsHidden = (nc.isNavigationBarHidden || nc.isToolbarHidden)
        } else {
            navigationBarsHidden = true
        }
        let shouldHidePageSelectionView =  navigationBarsHidden ||
            (pdfView.document?.pageCount ?? 0) <= 1
        
        if shouldHidePageSelectionView {
            pageSelectionViewTrailingConstraint.constant = -pageSelectionView.bounds.width
            // - self.view.safeAreaInsets.right
        } else {
            pageSelectionViewTrailingConstraint.constant = 0.0
        }
        
        let duration = (animated) ? TimeInterval(UINavigationController.hideShowBarDuration) : 0.0
        
        UIView.animate(withDuration: duration) {
            self.pageSelectionView.alpha = (shouldHidePageSelectionView) ? 0.0 : 1.0
            self.view.setNeedsLayout()
        }
    }
    
    @objc func onTap(_ tap: UITapGestureRecognizer) {
        guard let nc = navigationController else { return }
        
        let isHidden = (nc.isNavigationBarHidden || nc.isToolbarHidden)
        
        nc.setNavigationBarHidden(!isHidden, animated: true)
        nc.setToolbarHidden(!isHidden, animated: true)
        
        updateForNavigationBars(true)
    }
    
    @objc func onDoubleTap(_ tap: UITapGestureRecognizer) {
        pdfView.scaleToFit(true)
    }
}
