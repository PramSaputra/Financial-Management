//
//  NavAppearanceModifier.swift
//  NavBarStyling
//
//  Created by Stewart Lynch on 2021-03-23.
//

import SwiftUI

struct NavAppearanceModifier: ViewModifier {
    init(backgroundColor: UIColor, foregroundColor: UIColor, tintColor: UIColor?, hideSeparator: Bool, hideNavbarBackground: Bool) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: foregroundColor]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: foregroundColor]
        navBarAppearance.backgroundColor = backgroundColor
        
        if hideNavbarBackground {
            navBarAppearance.backgroundColor = .white
        }
        if hideSeparator {
            navBarAppearance.shadowColor = .clear
        }
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        if let tintColor = tintColor {
            UINavigationBar.appearance().tintColor = tintColor
        }
    }
    
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func navigationAppearance(backgroundColor: UIColor, foregroundColor: UIColor, tintColor: UIColor? = nil, hideSeparator: Bool = false, hideNavbarBackground: Bool = false) -> some View {
        self.modifier(NavAppearanceModifier(backgroundColor: backgroundColor, foregroundColor: foregroundColor, tintColor: tintColor, hideSeparator: hideSeparator, hideNavbarBackground: hideNavbarBackground))
    }
}
