//
//  UIScrollView+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-12-19.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation

#if os(iOS)

public extension UIScrollView {
    var isAtStart: Bool {
        return (contentOffset.x <= 0.0)
    }
    
    var isAtEnd: Bool {
        return (contentOffset.x >= (contentSize.width - bounds.width))
    }
    
    var isAtTop: Bool {
        return (contentOffset.y <= 0.0)
    }
    
    var isAtBottom: Bool {
        return (contentOffset.y >= (contentSize.height - bounds.height))
    }
}

#endif
