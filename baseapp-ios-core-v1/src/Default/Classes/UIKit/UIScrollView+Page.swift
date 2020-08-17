//
//  UIScrollView+Page.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-12-19.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation

public extension UIScrollView {
    public struct Page {
        public let x: Int
        public let y: Int
        
        public static var zero: Page {
            return Page(x: 0, y: 0)
        }
    }
}

public extension UIScrollView {
    var currentPage: UIScrollView.Page {
        return page(for: contentOffset)
    }
    
    var lastPage: UIScrollView.Page {
        return self.page(for: CGPoint(
            x: contentSize.width,
            y: contentSize.height
        ))
    }
    
    var centrePage: UIScrollView.Page {
        let lastPage = self.lastPage
        
        return Page(x: Int(CGFloat(lastPage.x) * 0.5),
                    y: Int(CGFloat(lastPage.y) * 0.5))
    }
    
    func page(for contentOffset: CGPoint) -> UIScrollView.Page {
        //        guard self.isPagingEnabled else { return Page.zero }
        guard bounds.width > 0.0 else { return Page.zero }
        guard bounds.height > 0.0 else { return Page.zero }
        
        return Page(x: Int(round(contentOffset.x / bounds.width)),
                    y: Int(round(contentOffset.y / bounds.height)))
    }
    
    func contentOffset(for page: UIScrollView.Page) -> CGPoint {
        return CGPoint(x: bounds.width * CGFloat(page.x),
                       y: bounds.height * CGFloat(page.y))
    }
}
