//
//  ViewController.swift
//  ColorChanger
//
//  Created by Ilya Klimenyuk on 23.10.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 15
        setColor()
    }

    @IBAction func sliderOnChange(_ sender: UISlider) {
        setColor()
        
        switch sender.tag {
        case 0: redLabel.text = string(from: sender)
        case 1: greenLabel.text = string(from: sender)
        case 2: blueLabel.text = string(from: sender)
        default: break
        }
        
    }
    
    private func string(from slider: UISlider) -> String{
        String(format: "%.01f", slider.value.rounded(.down))
    }
    
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value.rounded(.down) / 255.0),
            green: CGFloat(greenSlider.value.rounded(.down) / 255.0),
            blue: CGFloat(blueSlider.value.rounded(.down) / 255.0),
            alpha: 1
        )
    }
    
}

