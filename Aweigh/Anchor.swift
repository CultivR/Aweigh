//
//  Anchor.swift
//  Aweigh
//
//  Created by Jordan Kay on 3/8/18.
//  Copyright © 2018 Jordan Kay. All rights reserved.
//

public protocol Anchoring where Self: UIView {
    var anchoredViews: [UIView] { get }
    var anchoringInset: CGFloat! { get set }
    var anchoringMargin: CGFloat { get }
    var shouldAnimateKeyboard: Bool { get }
}

public extension Anchoring {
    var anchoringMargin: CGFloat {
        return 0
    }
    
    var shouldAnimateKeyboard: Bool {
        return true
    }

    mutating func animateAnchoredViews(using info: KeyboardInfo, adjusting views: [UIView]? = nil) {
        guard shouldAnimateKeyboard else { return }
        
        let distance = info.endFrame.minY - info.startFrame.minY
        let bottomView = anchoredViews.sorted { $0.frame.maxY < $1.frame.maxY }.last!
        if anchoringInset == nil {
            anchoringInset = UIApplication.shared.keyWindow!.frame.maxY - convert(bottomView.frame, to: nil).maxY - anchoringMargin
        }
        let offset: CGFloat = distance + CGFloat(distance < 0 ? 1 : -1) * anchoringInset
        
        UIView.animate(withDuration: info.duration, delay: 0, options: info.animationOptions, animations: { [anchoredViews] in
            anchoredViews.forEach { $0.transform.ty += offset }
            views?.forEach { $0.frame.size.height += offset }
        }, completion: nil)
    }
}
