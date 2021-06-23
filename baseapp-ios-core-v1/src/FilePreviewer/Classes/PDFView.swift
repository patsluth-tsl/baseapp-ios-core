//
//  PDFView.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-10-16.
//  Copyright © 2019 SilverLogic. All rights reserved.
//

import Foundation
import PDFKit
import RxCocoa
import RxSwift
import RxSwiftExt
import UIKit

@available(iOS 11.0, *)
internal class PDFView: PDFKit.PDFView {
	override var document: PDFDocument? {
		didSet {
			scrolledPageIndex = 0
		}
	}
	
	@objc dynamic private(set) var scrolledPageIndex: Int = 0 {
		didSet {
			guard scrolledPageIndex != oldValue else { return }
		}
	}
	
	private var currentPageIndex: Int {
		guard let currentPage = currentPage else { return 0 }
		guard let currentPageIndex = document?.index(for: currentPage) else { return 0 }
		return currentPageIndex
	}
	
	var pageCount: Int {
		return (document?.pageCount ?? 0)
	}
    
    private var disposeBag = DisposeBag()
	
	fileprivate(set) var scrollView: UIScrollView! = nil {
		didSet {
            disposeBag = DisposeBag()
            
			guard let newValue = scrollView else { return }
            
            newValue.rx.observe(CGPoint.self,
                                #keyPath(UIScrollView.contentOffset),
                                options: [.initial, .new],
                                retainSelf: true)
                .asDriver(onErrorJustReturn: .zero)
                .unwrap()
                .drive(onNext: { [weak self] contentOffset in
                    guard let `self` = self else { return }
                    guard self.scrollView != nil else { return }
                    self.scrolledPageIndex = {
                        if self.scrollView.isAtTop {
                            return 0
                        } else if self.scrollView.isAtBottom {
                            return self.pageCount - 1
                        } else {
                            let translation = self.scrollView.panGestureRecognizer
                                .translation(in: self.scrollView.superview)
                            let visibleRect = CGRect(
                                origin: self.scrollView.contentOffset,
                                size: self.scrollView.bounds.size
                            )
                            let centre = CGPoint(
                                x: visibleRect.width * 0.5,
                                y: (visibleRect.height * 0.5) + copysign(1.0, translation.y)
                            )
                            
                            guard let page = self.page(for: centre, nearest: true) else {
                                return self.currentPageIndex
                            }
                            guard let pageIndex = self.document?.index(for: page) else {
                                return self.currentPageIndex
                            }
                            
                            return pageIndex
                        }
                    }()
                })
                .disposed(by: disposeBag)
		}
	}
	
	
	
	
	
//	override func willMove(toSuperview newSuperview: UIView?)
//	{
//	}
	
	override func didAddSubview(_ subview: UIView) {
		super.didAddSubview(subview)
		
		guard let _scrollView = subview as? UIScrollView else { return }
		scrollView = _scrollView
	}
	
	deinit {
		scrollView = nil
	}
	
	func scaleToFit(_ animated: Bool) {
		minScaleFactor = min(minScaleFactor, scaleFactorForSizeToFit)
		maxScaleFactor = max(maxScaleFactor, scaleFactorForSizeToFit)
		
		scaleFactor = scaleFactorForSizeToFit
	}
}
