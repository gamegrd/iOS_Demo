//
//  CAReplicatorLayerViewController.swift
//  24.CalayerTutorial
//
//  Created by yy on 2019/9/19.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit

class CAReplicatorLayerViewController: UIViewController {

    @IBOutlet weak var viewForReplicatorLayer: UIView!
    @IBOutlet weak var layerSizeSlider: UISlider!
    @IBOutlet weak var layerSizeSliderValueLabel: UILabel!
    @IBOutlet weak var instanceCountSlider: UISlider!
    @IBOutlet weak var instanceCountSliderValueLabel: UILabel!
    @IBOutlet weak var instanceDelaySlider: UISlider!
    @IBOutlet weak var instanceDelaySliderValueLabel: UILabel!
    @IBOutlet weak var offsetRedSwitch: UISwitch!
    @IBOutlet weak var offsetGreenSwitch: UISwitch!
    @IBOutlet weak var offsetBlueSwitch: UISwitch!
    @IBOutlet weak var offsetAlphaSwitch: UISwitch!
    
     let lengthMultiplier: CGFloat = 3.0
     let replicatorLayer = CAReplicatorLayer()
     let instanceLayer = CALayer()
     let whiteColor = UIColor.white.cgColor
     let fadeAnimation = CABasicAnimation(keyPath: "opacity")
    
    // MARK: - Quick reference
    func setUpReplicatorLayer()  {
        
        replicatorLayer.frame =  viewForReplicatorLayer.bounds
        let count = instanceCountSlider.value
        replicatorLayer.instanceCount = Int(count)
        replicatorLayer.preservesDepth = false
        replicatorLayer.instanceColor = whiteColor
        replicatorLayer.instanceRedOffset = offsetValueForSwitch(offsetRedSwitch)
        replicatorLayer.instanceGreenOffset = offsetValueForSwitch(offsetGreenSwitch)
        replicatorLayer.instanceBlueOffset = offsetValueForSwitch(offsetBlueSwitch)
        replicatorLayer.instanceAlphaOffset = offsetValueForSwitch(offsetAlphaSwitch)
        let angle = Float(Double.pi * 2.0) / count
         replicatorLayer.instanceTransform = CATransform3DMakeRotation(CGFloat(angle), 0.0, 0.0, 1.0)
   
    }
    
    func setUpInstanceLayer() {
      let layerWidth = CGFloat(layerSizeSlider.value)
      let midX = viewForReplicatorLayer.bounds.midX - layerWidth / 2.0
//      instanceLayer.frame = CGRect(x: midX, y: 0.0, width: layerWidth, height: layerWidth * lengthMultiplier)
        instanceLayer.frame = CGRect(x: midX, y: 0.0, width: layerWidth, height: layerWidth)
        instanceLayer.cornerRadius = layerWidth/2.0
      instanceLayer.backgroundColor = whiteColor
    }
    
    func setUpLayerFadeAnimation() {
      fadeAnimation.fromValue = 1.0
      fadeAnimation.toValue = 0.0
      fadeAnimation.repeatCount = Float(Int.max)
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpReplicatorLayer()
        viewForReplicatorLayer.layer.addSublayer(replicatorLayer)
        setUpInstanceLayer()
        replicatorLayer.addSublayer(instanceLayer)
        setUpLayerFadeAnimation()
        instanceDelaySliderChanged(instanceDelaySlider)
        updateLayerSizeSliderValueLabel()
        updateInstanceCountSliderValueLabel()
        updateInstanceDelaySliderValueLabel()
        
    }
    
     // MARK: - IBActions
    @IBAction func layerSizeSliderChanged(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        instanceLayer.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: value, height: value * lengthMultiplier))
        updateLayerSizeSliderValueLabel()
    }
    
    @IBAction func instanceCountSliderChanged(_ sender: UISlider) {
        replicatorLayer.instanceCount = Int(sender.value)
        replicatorLayer.instanceAlphaOffset = offsetValueForSwitch(offsetAlphaSwitch)
        updateInstanceCountSliderValueLabel()
    }
    
    @IBAction func instanceDelaySliderChanged(_ sender: UISlider) {
        
        if sender.value > 0.0 {
          replicatorLayer.instanceDelay = CFTimeInterval(sender.value / Float(replicatorLayer.instanceCount))
          setLayerFadeAnimation()
        } else {
          replicatorLayer.instanceDelay = 0.0
          instanceLayer.opacity = 1.0
          instanceLayer.removeAllAnimations()
        }
        
        updateInstanceDelaySliderValueLabel()
        
    }
    
    @IBAction func offsetSwitchChanged(_ sender: UISwitch) {
        
        switch sender {
        case offsetRedSwitch:
          replicatorLayer.instanceRedOffset = offsetValueForSwitch(sender)
        case offsetGreenSwitch:
          replicatorLayer.instanceGreenOffset = offsetValueForSwitch(sender)
        case offsetBlueSwitch:
          replicatorLayer.instanceBlueOffset = offsetValueForSwitch(sender)
        case offsetAlphaSwitch:
          replicatorLayer.instanceAlphaOffset = offsetValueForSwitch(sender)
        default:
          break
        }
    }
    
    
    // MARK: - Triggered actions
    func setLayerFadeAnimation() {
      instanceLayer.opacity = 0.0
      fadeAnimation.duration = CFTimeInterval(instanceDelaySlider.value)
      instanceLayer.add(fadeAnimation, forKey: "FadeAnimation")
    }
    
    // MARK: - Helpers
    
    func offsetValueForSwitch(_ offsetSwitch: UISwitch) -> Float {
      if offsetSwitch == offsetAlphaSwitch {
        let count = Float(replicatorLayer.instanceCount)
        return offsetSwitch.isOn ? -1.0 / count : 0.0
      } else {
        return offsetSwitch.isOn ? 0.0 : -0.05
      }
    }
    
    func updateLayerSizeSliderValueLabel() {
      let value = layerSizeSlider.value
      layerSizeSliderValueLabel.text = String(format: "%.0f x %.0f", value, value * Float(lengthMultiplier))
    }
    
    func updateInstanceCountSliderValueLabel() {
      instanceCountSliderValueLabel.text = String(format: "%.0f", instanceCountSlider.value)
    }
    
    func updateInstanceDelaySliderValueLabel() {
      instanceDelaySliderValueLabel.text = String(format: "%.0f", instanceDelaySlider.value)
    }
    
    
}
