//
//  Keyboard.swift
//  Aweigh
//
//  Created by Jordan Kay on 3/8/18.
//  Copyright © 2018 Jordan Kay. All rights reserved.
//

public struct KeyboardInfo {
    private let userInfo: [AnyHashable: Any]
    
    public init(userInfo: [AnyHashable: Any]) {
        self.userInfo = userInfo
    }
    
    public var duration: TimeInterval {
        return userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
    }
    
    public var animationOptions: UIView.AnimationOptions {
        let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        return UIView.AnimationOptions(rawValue: curve << 16)
    }
    
    public var startFrame: CGRect {
        return (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
    }
    
    public var endFrame: CGRect {
        return (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    }
}

@objc public protocol KeyboardObserving {
    func keyboardWillAnimate(notification: Notification)
    func keyboardDidAnimate(notification: Notification)
}

public extension KeyboardObserving {
    func addKeyboardObservers() {
        for name: Notification.Name in [UIResponder.keyboardWillShowNotification, UIResponder.keyboardWillHideNotification] {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAnimate), name: name, object: nil)
        }
        for name: Notification.Name in [UIResponder.keyboardDidShowNotification, UIResponder.keyboardDidHideNotification] {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidAnimate), name: name, object: nil)
        }
    }
}
