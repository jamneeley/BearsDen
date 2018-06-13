//
//  GoalsCollectionViewCell.swift
//  BearsDen
//
//  Created by James Neeley on 6/6/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit
protocol GoalsCollectionViewCellDelegate: class {
    func presentDeleteAlert(goal: Goal)
}

class GoalsCollectionViewCell: UICollectionViewCell {
    
    let deleteButton = UIButton()
    //ProgressBar
    let progressLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    let percentageLabel = UILabel()
    var pulsatingLayer: CAShapeLayer!
    let completedLabel = UILabel()
    let circleTextStack = UIStackView()
    // belowProgressBar
    let seperator = UIView()
    var animations = 0
    var isProgressBarReset = false {
        didSet {
            resetProgressBar()
        }
    }
    
    var goal: Goal? {
        didSet {
            animatePulsatingLayer()
            //for when i get other objects below progress circle
           //updateViews()?
        }
    }
    var percentComplete: Float? {
        didSet {
            guard let fraction = percentComplete else {return}
            let percent = Int(fraction * 100)
            percentageLabel.text = "\(percent)%"
            if animations < 1 {
                let _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(animateProgress), userInfo: nil, repeats: false)
                animations += 1
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        progressLayer.removeAnimation(forKey: "progressAnimation")
        animations = 0
        
        //BUG.....It prepares for reuse on the first cell which resets the animation...
    }
    
    weak var delegate: GoalsCollectionViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupDeleteButton()
        setupProgressCircle()
        addSubview(seperator)
        addConstraintsWithFormat(format: "H:|-25-[v0]-25-|", views: seperator)
        addConstraintsWithFormat(format: "V:|-\(frame.height * 0.90)-[v0(2)]", views: seperator)
        seperator.randomBackgroundColor(hueFrom: 35, hueTo: 55, satFrom: 90, satTo: 100, brightFrom: 90, brightTo: 100)
        seperator.layer.cornerRadius = 4
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
    
    func setupDeleteButton() {
    deleteButton.setImage(#imageLiteral(resourceName: "TrashIcon"), for: .normal)
        addSubview(deleteButton)
        deleteButton.addTarget(self, action: #selector(deleteGoalButtonPressed), for: .touchUpInside)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        deleteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: leadingAnchor, constant: 40).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
    }
    
    @objc func deleteGoalButtonPressed() {
        guard let goal = goal else {return}
        delegate?.presentDeleteAlert(goal: goal)
    }

    
    func setupProgressCircle() {
        let x = frame.width * 0.5
        let y = frame.height * 0.45
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
        basicAnimation.duration = 0.6
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        basicAnimation.isRemovedOnCompletion = false
        if let percent = percentComplete {
            basicAnimation.toValue = percent
        } else {
            basicAnimation.toValue = 0.0
        }
        progressLayer.add(basicAnimation, forKey: "progressAnimation")
    }
    
    func resetProgressBar() {
    progressLayer.removeAnimation(forKey: "progressAnimation")
    }
}








