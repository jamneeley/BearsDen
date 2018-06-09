//
//  GoalsCollectionViewCell.swift
//  BearsDen
//
//  Created by James Neeley on 6/6/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class GoalsCollectionViewCell: UICollectionViewCell {

    let seperator = UIView()
    var titleLabel = UILabel()
    let progressLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    let percentageLabel = UILabel()
    var pulsatingLayer: CAShapeLayer!
    let completedLabel = UILabel()
    let circleTextStack = UIStackView()
    
    var goal: Goal? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let localGoal = goal else {return}
        titleLabel.text = localGoal.name
        animatePulsatingLayer()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(animateProgress), userInfo: nil, repeats: false)
        self.backgroundColor = .white
        setupProgressCircle()
        addSubview(seperator)
        addSubview(titleLabel)  
        addConstraintsWithFormat(format: "H:|-25-[v0]-25-|", views: seperator)
        addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: titleLabel)
        addConstraintsWithFormat(format: "V:|-\(frame.height * 0.53)-[v1(80)]-5-[v0(2)]", views: seperator, titleLabel)
        seperator.backgroundColor = Colors.mediumGray
        seperator.layer.cornerRadius = 4
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleEnterForeground), name: .UIApplicationWillEnterForeground, object: nil)
    }
    @objc private func handleEnterForeground() {
        animatePulsatingLayer()
    }
    
    func setupProgressCircle() {
        let x = frame.width * 0.5
        let y = frame.height * 0.25
        let radius = frame.width * 0.75 / 2
        
        let circlePosition = CGPoint(x: x, y: y)
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: frame.width * 0.75 / 2, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        
        setupNotificationObservers()
    
        //create Pulsating layer
        pulsatingLayer = CAShapeLayer()
        pulsatingLayer.path = circularPath.cgPath
        pulsatingLayer.strokeColor = Colors.clear.cgColor
        pulsatingLayer.lineWidth = 15
        pulsatingLayer.fillColor = Colors.pulsingGreen.cgColor
        pulsatingLayer.lineCap = kCALineCapRound
        pulsatingLayer.position = circlePosition
        layer.addSublayer(pulsatingLayer)
        

        //create tracklayer
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = Colors.lightGray.cgColor
        trackLayer.lineWidth = 15
        trackLayer.fillColor = Colors.white.cgColor
        trackLayer.lineCap = kCALineCapRound
        layer.addSublayer(trackLayer)
        trackLayer.position = circlePosition
    
        //create progress layer
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = Colors.green.cgColor
        progressLayer.lineWidth = 15
        progressLayer.fillColor = Colors.clear.cgColor
        progressLayer.lineCap = kCALineCapRound
        progressLayer.position = circlePosition
        progressLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)
        
        //create label
        addSubview(circleTextStack)
        circleTextStack.addArrangedSubview(percentageLabel)
        circleTextStack.addArrangedSubview(completedLabel)
        circleTextStack.axis = .vertical
        circleTextStack.distribution = .fill
        circleTextStack.translatesAutoresizingMaskIntoConstraints = false
        circleTextStack.topAnchor.constraint(equalTo: topAnchor, constant: y - radius + 80).isActive = true
        circleTextStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: x - radius + 40).isActive = true
        circleTextStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -x + radius - 40).isActive = true
        circleTextStack.bottomAnchor.constraint(equalTo: topAnchor, constant: y + radius - 80).isActive = true
        
        //text!
        percentageLabel.text = " 100%"
        percentageLabel.textAlignment = .center
        percentageLabel.font = UIFont.boldSystemFont(ofSize: 35)
        completedLabel.text = "Completed"
        completedLabel.textAlignment = .center
        completedLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    private func animatePulsatingLayer() {
        print("pulsating")
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.18
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        pulsatingLayer.add(animation, forKey: "pulsing")
    }
    
    
    
    @objc private func animateProgress() {
        print("animation should happen")
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0.75
        basicAnimation.duration = 1
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        basicAnimation.isRemovedOnCompletion = false
        progressLayer.add(basicAnimation, forKey: "urSoBasic")
    }

}












