//
//  PDFPageSelectionView.swift
//  FilePreviewer
//
//  Created by Pat Sluth on 2017-12-08.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation
import PDFKit
import RxCocoa
import RxSwift
import RxSwiftExt
import UIKit


@available(iOS 11.0, *)
internal class PDFPageSelectionViewStackView: UIStackView {
	
}


@available(iOS 11.0, *)
internal class PDFPageSelectionView: UIView, UIGestureRecognizerDelegate {
    private var thumbnailViews = [Int: UIImageView]()
    private var disposeBag = DisposeBag()
    
	weak var pdfView: PDFView? = nil {
        didSet {
            disposeBag = DisposeBag()
            
			for subview in subviews where subview is PDFPageSelectionViewStackView {
                subview.removeFromSuperview()
            }
            
            thumbnailViews.removeAll()
			
            guard let newValue = pdfView else { return }
			guard let pdfDocument = newValue.document else { return }
            
            let stackView = PDFPageSelectionViewStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
			stackView.axis = NSLayoutConstraint.Axis.vertical
            stackView.alignment = UIStackView.Alignment.center
            stackView.distribution = UIStackView.Distribution.fillEqually
            stackView.spacing = 10.0
            stackView.isLayoutMarginsRelativeArrangement = false
            addSubview(stackView)
			stackView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 10.0
            ).isActive = true
            stackView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -10.0
            ).isActive = true
            stackView.topAnchor.constraint(
                equalTo: topAnchor
            ).isActive = true
            stackView.bottomAnchor.constraint(
                equalTo: bottomAnchor
            ).isActive = true
//            stackView.heightAnchor.constraint(lessThanOrEqualTo: self.heightAnchor).isActive = true
            
            for index in stride(from: 0, to: pdfDocument.pageCount, by: 1) {
				guard let pdfPage = pdfDocument.page(at: index) else { continue }
				
				let imageView = UIImageView()
				imageView.translatesAutoresizingMaskIntoConstraints = false
				imageView.contentMode = UIView.ContentMode.scaleAspectFit
				stackView.addArrangedSubview(imageView)
				
				DispatchQueue.global().async {
					let thumbnailImage = pdfPage.thumbnail(
                        of: CGSize(width: 100.0, height: 100.0),
                        for: PDFDisplayBox.mediaBox
                    )
					DispatchQueue.main.async {
						imageView.image = thumbnailImage
					}
				}
				
				thumbnailViews.updateValue(imageView, forKey: index)
            }
            
            self.setNeedsDisplay()
			
            newValue.rx.observe(Int.self,
                                #keyPath(PDFView.scrolledPageIndex),
                                options: [.initial, .new],
                                retainSelf: true)
                .asDriver(onErrorJustReturn: .zero)
                .unwrap()
                .drive(onNext: { [weak self] pageIndex in
                    guard let `self` = self else { return }
                    guard self.pdfView != nil else { return }
                    
                    for (index, thumbnailView) in self.thumbnailViews {
                        if index == pageIndex {
                            thumbnailView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                        } else {
                            thumbnailView.transform = CGAffineTransform.identity
                        }
                    }
                })
                .disposed(by: disposeBag)
        }
    }
    
	override func awakeFromNib() {
		super.awakeFromNib()
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.onPan(_:)))
        pan.delegate = self
        addGestureRecognizer(pan)
	}
    
    // MARK: - UIGestureRecognizerDelegate
    
    internal override func gestureRecognizerShouldBegin(
        _ gestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        if let pan = gestureRecognizer as? UIPanGestureRecognizer {
            let velocity = pan.velocity(in: self)
            return (fabs(velocity.y) > fabs(velocity.x))
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
    
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return false
    }
    
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return true
    }
}


@available(iOS 11.0, *)
private extension PDFPageSelectionView {
    @objc fileprivate func onPan(_ pan: UIPanGestureRecognizer) {
        switch pan.state {
        case .began, .changed, .ended:
            let location = pan.location(in: self)
            for (index, thumbnailView) in thumbnailViews {
                guard thumbnailView.frame.contains(location) else { continue }
                guard let page = pdfView?.document?.page(at: index) else { return }
                pdfView?.go(to: page)
                break
            }
        case _:
            break
        }
    }
}
