//
//  SelectableModel.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-03-01.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

#if canImport(DifferenceKit)
import DifferenceKit
#endif
import RxCocoa
import RxSwift
import UIKit


public class SelectableModel<Base> {
    public let base: Base
    public let isSelected: BehaviorRelay<Bool>
    
    public init(_ base: Base, isSelected: Bool) {
        self.base = base
        self.isSelected = BehaviorRelay<Bool>(value: isSelected)
    }
}


// MARK: - Equatable
extension SelectableModel: Equatable
where Base: Equatable {
    public static func == (lhs: SelectableModel<Base>, rhs: SelectableModel<Base>) -> Bool {
        return (lhs.base == rhs.base)
    }
}


// MARK: - Hashable
extension SelectableModel: Hashable
where Base: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.base.hashValue)
        hasher.combine(self.isSelected.value)
    }
}


#if canImport(DifferenceKit)

// MARK: - Differentiable, ContentEquatable
public extension SelectableModel: Differentiable, ContentEquatable
where Base: Differentiable {
    typealias DifferenceIdentifier = Base.DifferenceIdentifier
    
    var differenceIdentifier: SelectableModel<Base>.DifferenceIdentifier {
        return self.base.differenceIdentifier
    }
    
    func isContentEqual(to source: SelectableModel<Base>) -> Bool {
        return self.base.isContentEqual(to: source.base)
    }
}

#endif
