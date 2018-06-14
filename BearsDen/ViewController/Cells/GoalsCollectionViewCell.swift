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
    
    //MARK: - Properties
    
    let deleteButton = UIButton()
    //ProgressBar
    let progressLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    let percentageLabel = UILabel()
    var pulsatingLayer: CAShapeLayer!
    let completedLabel = UILabel()
    let circleTextStack = UIStackView()
    
    let seperator = UIView()
    
    //Settable
    
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
    
    weak var delegate: GoalsCollectionViewCellDelegate?
    
    //MARK: - Cell initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        progressLayer.removeAnimation(forKey: "progressAnimation")
        animations = 0
        
        //BUG.....It prepares for reuse on the first cell which resets the animation...
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleEnterForeground), name: .UIApplicationWillEnterForeground, object: nil)
    }
    
    @objc private func handleEnterForeground() {
        animatePulsatingLayer()
    }
    
    @objc func deleteGoalButtonPressed() {
        guard let goal = goal else {return}
        delegate?.presentDeleteAlert(goal: goal)
    }
    
    func resetProgressBar() {
        progressLayer.removeAnimation(forKey: "progressAnimation")
    }

////////////////////
    //MARK: - Views
///////////////////
    
    func setupViews() {
        self.backgroundColor = .white
        setupDeleteButton()
        setupProgressCircle()
        setupSeperator()
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
    
    func setupProgressCircle() {
        let x = frame.width * 0.5
        let y = frame.height * 0.45
        let radius = frame.width * 0.75 / 2
        
        let circlePosition = CGPoint(x: x, y: y)
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: frame.width * 0.75 / 2, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)

        setupNotificationObservers()

        //create Pulsating layer
        pulsatingLayer = CAShapeLayer()
        setupProgressPath(ForLayer: pulsatingLayer, strokColor: Colors.clear, fillColor: Colors.pulsingGreen, path: circularPath.cgPath, position: circlePosition)
        
        setupProgressPath(ForLayer: trackLayer, strokColor: Colors.lightGray, fillColor: Colors.white, path: circularPath.cgPath, position: circlePosition)
        
        setupProgressPath(ForLayer: progressLayer, strokColor: Colors.green, fillColor: Colors.clear, path: circularPath.cgPath, position: circlePosition)

        progressLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        progressLayer.strokeEnd = 0
        
        setupProgressTextStack(x: x, y: y, radius: radius)
    }
    
    func setupProgressPath(ForLayer layer: CAShapeLayer, strokColor: UIColor, fillColor: UIColor, path: CGPath, position: CGPoint) {
        layer.path = path
        layer.position = position
        layer.lineWidth = 15
        layer.strokeColor = fillColor.cgColor
        layer.fillColor = fillColor.cgColor
        layer.lineCap = kCALineCapRound
        self.layer.addSublayer(layer)
    }
    
    func setupProgressTextStack(x: CGFloat, y: CGFloat, radius: CGFloat) {
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
        
        percentageLabel.text = " 100%"
        percentageLabel.textAlignment = .center
        percentageLabel.font = UIFont.boldSystemFont(ofSize: 35)
        completedLabel.text = "Completed"
        completedLabel.textAlignment = .center
        completedLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    func setupSeperator() {
        addSubview(seperator)
        addConstraintsWithFormat(format: "H:|-25-[v0]-25-|", views: seperator)
        addConstraintsWithFormat(format: "V:|-\(frame.height * 0.90)-[v0(2)]", views: seperator)
        seperator.randomBackgroundColor(hueFrom: 35, hueTo: 55, satFrom: 90, satTo: 100, brightFrom: 90, brightTo: 100)
        seperator.layer.cornerRadius = 4
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
}








