//
//  StatusBar.swift
//  Aweigh
//
//  Created by Jordan Kay on 3/8/18.
//  Copyright © 2018 Jordan Kay. All rights reserved.
//

public var statusBarHeight: CGFloat {
    return UIApplication.shared.statusBarFrame.height
}

public var defaultStatusBarHeight: CGFloat {
    return (statusBarHeight == 40) ? 20 : statusBarHeight
}
