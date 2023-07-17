//
//  HabitDetailViewController.swift
//  Habits
//
//  Created by Олег Алексеев on 12.07.2023.
//

import UIKit

class HabitDetailViewController: UIViewController {
    
    let gradient = CAGradientLayer()
    
    var gradientSet = [[CGColor]]()
    var currentGradient: Int = 0
    
    let gradientOne = UIColor(
        red: 48/255,
        green: 62/255,
        blue: 103/255,
        alpha: 1).cgColor
    
    let gradientTwo = UIColor(
        red: 244/255,
        green: 88/255,
        blue: 53/255,
        alpha: 1).cgColor
    
    let gradientThree = UIColor(
        red: 196/255,
        green: 70/255,
        blue: 107/255,
        alpha: 1).cgColor

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        gradientSet.append([gradientOne, gradientTwo])
        gradientSet.append([gradientTwo, gradientThree])
        gradientSet.append([gradientThree, gradientOne])
        
        gradient.frame = self.view.bounds
        gradient.colors = gradientSet[currentGradient]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.drawsAsynchronously = true
        self.view.layer.addSublayer(gradient)
        
        animateGradient()
    }
    
    func animateGradient() {
        if currentGradient < gradientSet.count - 1 {
            currentGradient += 1
        } else {
            currentGradient = 0
        }
        
        let gradientChangeAnimation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.colors))
        gradientChangeAnimation.duration = 2.0
        gradientChangeAnimation.toValue = gradientSet[currentGradient]
        gradientChangeAnimation.fillMode = .forwards
        gradientChangeAnimation.delegate = self
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradient.add(gradientChangeAnimation, forKey: "colors")
    }
}

extension HabitDetailViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            gradient.colors = gradientSet[currentGradient]
            animateGradient()
        }
    }
}
