//
//  CATiledLayerViewController.swift
//  24.CalayerTutorial
//
//  Created by yy on 2019/9/19.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit

class CATiledLayerViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var tiledImageLayerButton: UIBarButtonItem!
    @IBOutlet weak var zoomLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewForTiledLayer: TilingView!
    @IBOutlet weak var fadeDurationSlider: UISlider!
    @IBOutlet weak var fadeDurationSliderValueLabel: UILabel!
    @IBOutlet weak var tileSizeSlider: UISlider!
    @IBOutlet weak var tileSizeSliderValueLabel: UILabel!
    @IBOutlet weak var levelsOfDetailSlider: UISlider!
    @IBOutlet weak var levelsOfDetailSliderValueLabel: UILabel!
    @IBOutlet weak var detailBiasSlider: UISlider!
    @IBOutlet weak var detailBiasSliderValueLabel: UILabel!
    @IBOutlet weak var zoomScaleSlider: UISlider!
    @IBOutlet weak var zoomScaleSliderValueLabel: UILabel!
    
    
    var tiledLayer: TiledLayer {
      return viewForTiledLayer.layer as! TiledLayer
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = scrollView.frame.size
        updateFadeDurationSliderValueLabel()
        updateTileSizeSliderValueLabel()
        updateLevelsOfDetailSliderValueLabel()
        updateDetailBiasSliderValueLabel()
        updateZoomScaleSliderValueLabel()
    }
    
   
    deinit {
      TiledLayer.setFadeDuration(CFTimeInterval(0.25))
    }
    
    
    
    // MARK: - IBActions

    @IBAction func fadeDurationSliderChanged(_ sender: UISlider) {
        TiledLayer.setFadeDuration(CFTimeInterval(sender.value))
        updateFadeDurationSliderValueLabel()
        tiledLayer.contents = nil
        tiledLayer.setNeedsDisplay(tiledLayer.bounds)
    }
    
    @IBAction func tileSizeSliderChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        tiledLayer.tileSize = CGSize(width: value, height: value)
        updateTileSizeSliderValueLabel()
    }
    
    @IBAction func levelsOfDetailSliderChanged(_ sender: UISlider) {
        tiledLayer.levelsOfDetail = Int(sender.value)
        updateLevelsOfDetailSliderValueLabel()
    }
    
    @IBAction func levelsOfDetailSliderTouchedUp(_ sender: Any) {
        showZoomLabel()
    }
    
    func showZoomLabel() {
      zoomLabel.alpha = 1.0
      zoomLabel.isHidden = false
      let label = zoomLabel
      
      UIView.animate(withDuration: 1.0, delay: 0.0, options: [], animations: {
        label?.alpha = 0
        }, completion: { _ in
          label?.isHidden = true
      })
    }

    @IBAction func detailBiasSliderChanged(_ sender: UISlider) {
        tiledLayer.levelsOfDetailBias = Int(sender.value)
        updateDetailBiasSliderValueLabel()
    }
    @IBAction func detailBiasSliderTouchedUp(_ sender: Any) {
        showZoomLabel()
    }
    
    @IBAction func zoomScaleSliderChanged(_ sender: UISlider) {
    }
    
    
    
     // MARK: - Helpers
    func updateFadeDurationSliderValueLabel() {
      fadeDurationSliderValueLabel.text = String(format: "%.2f", adjustableFadeDuration)
    }
    
    func updateTileSizeSliderValueLabel() {
      tileSizeSliderValueLabel.text = "\(Int(tiledLayer.tileSize.width))"
    }

    func updateLevelsOfDetailSliderValueLabel() {
      levelsOfDetailSliderValueLabel.text = "\(tiledLayer.levelsOfDetail)"
    }

    func updateDetailBiasSliderValueLabel() {
      detailBiasSliderValueLabel.text = "\(tiledLayer.levelsOfDetailBias)"
    }
    
    func updateZoomScaleSliderValueLabel() {
      zoomScaleSliderValueLabel.text = "\(Int(scrollView.zoomScale))"
    }
    
    // MARK: UIScrollViewDelegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
      return viewForTiledLayer
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
      zoomScaleSlider.setValue(Float(scrollView.zoomScale), animated: true)
      updateZoomScaleSliderValueLabel()
    }
    
}
