//
//  Animation.swift
//  Personal Quiz
//
//  Created by Михаил Медведев on 11/05/2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import UIKit

//MARK: Hide StackViews

func hideStackViews(in stackViews: [UIStackView?], except stackView: UIStackView) {
    
    for item in stackViews {
        if item == stackView {
            item?.showAnimated()
        } else {
            item?.hideAnimated()
        }
        
    }
}

extension UIView {
    
    func hideAnimated() {
        if !self.isHidden {
            UIView.animate(
                withDuration: 0.35,
                delay: 0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 1,
                options: [],
                animations: {
                    self.isHidden = true
                    self.layoutIfNeeded()
            },
                completion: nil
            )
        }
    }

    func showAnimated() {
        if self.isHidden {
            UIView.animate(
                withDuration: 0.35,
                delay: 0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 1,
                options: [],
                animations: {
                    self.isHidden = false
                    self.layoutIfNeeded()
            },
                completion: nil
            )

        }
    }
}
