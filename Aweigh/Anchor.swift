//
//  Anchor.swift
//  Aweigh
//
//  Created by Jordan Kay on 3/8/18.
//  Copyright © 2018 Jordan Kay. All rights reserved.
//

public protocol Anchoring: class {
    var anchoredView: UIView! { get }
    var didAnchor: Bool { get set }
    
    func finishAnchoringView()
}

public extension Anchoring where Self: UIView {
    func finishAnchoringView() {
        return
    }
    
    func anchorView() {
        guard !didAnchor, anchoredView != nil else { return }
        if #available(iOS 11.0, *) {
            let anchoredHeight = anchoredView.bounds.height + safeAreaInsets.bottom
            anchoredView.frame.origin.y = frame.maxY - anchoredHeight
            anchoredView.frame.size.height = anchoredHeight
        }
        finishAnchoringView()
        didAnchor = true
    }
}

public extension UIView {
    var anchoringInsets: UIEdgeInsets {
        if #available(iOS 11, *) {
            return safeAreaInsets
        } else {
            return .zero
        }
    }
}
