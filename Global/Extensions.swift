//
//  Extensions.swift
//  CoffeeBagel
//
//  Created by Hari Bista on 10/30/21.
//  Copyright © 2021 Hari Bista. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    
    // auto-layout section
    private func pinEdgesToSuperView(leading:CGFloat, trailing:CGFloat, top:CGFloat, bottom:CGFloat) {
        if let superView = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            let leadingConstraint = self.leadingAnchor.constraint(equalTo: superView.leadingAnchor)
            leadingConstraint.constant = leading
            
            let trailingConstraint = self.trailingAnchor.constraint(equalTo: superView.trailingAnchor)
            trailingConstraint.constant = -trailing
            
            let topConstraint = self.topAnchor.constraint(equalTo: superView.topAnchor)
            topConstraint.constant = top
            
            let bottomConstraint = self.bottomAnchor.constraint(equalTo: superView.bottomAnchor)
            bottomConstraint.constant = -bottom
            
            NSLayoutConstraint.activate([leadingConstraint,trailingConstraint,
                                         topConstraint,bottomConstraint])
        }
    }
    
    @objc func addSubviewPinningEdges(subView: UIView, leading:CGFloat = 0, trailing: CGFloat = 0, top:CGFloat = 0, bottom:CGFloat = 0){
        self.addSubview(subView)
        subView.pinEdgesToSuperView(leading: leading, trailing: trailing, top: top, bottom: bottom)
    }
    
    @objc func addSubviewAtCenterXY(subView:UIView){
        self.addSubviewAtCenterXY(subView: subView, centerX: 0, centerY: 0)
    }
    
    @objc func addSubviewAtCenterXY(subView:UIView, centerX:CGFloat, centerY:CGFloat){
        self.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        let centerXConstraint = subView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        centerXConstraint.constant = centerX
        
        let centerYConstraint = subView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        centerYConstraint.constant = centerY
        
        let widthConstraint = subView.widthAnchor.constraint(equalToConstant: subView.bounds.width)
        let heightConstraint = subView.heightAnchor.constraint(equalToConstant: subView.bounds.height)
        
        NSLayoutConstraint.activate([centerXConstraint,centerYConstraint,widthConstraint,heightConstraint])
    }
    
    @objc func getAllSubviews(view:UIView) -> [UIView] {
        var subviews = [UIView]()
        for subview in view.subviews {
            subviews += self.getAllSubviews(view:subview)
            subviews.append(subview)
        }
        return subviews
    }
}
