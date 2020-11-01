//
//  ColorSettingsViewController.swift
//  ColorPicker
//
//  Created by Ilya Klimenyuk on 23.10.2020.
//

import UIKit

class ColorSettingsViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var delegate: NewColorViewControllerDelegate!
    var introVCColor = UIColor(red: 1,
                               green: 1,
                               blue: 1,
                               alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        colorView.backgroundColor = introVCColor
        
        updateSlidersValues()
        setText(for: redLabel, greenLabel, blueLabel)
        setTextFieldsProperties(for: redTextField,
                                greenTextField,
                                blueTextField)
        
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        setColor()
        
        switch sender.tag {
        case 0:
            redLabel.text = string(from: sender)
            redTextField.text = string(from: sender)
        case 1:
            greenLabel.text = string(from: sender)
            greenTextField.text = string(from: sender)
        case 2:
            blueLabel.text = string(from: sender)
            blueTextField.text = string(from: sender)
        default: break
        }
    }
    
    @IBAction func doneButtonTapped() {
        delegate.setColor(colorView.backgroundColor!)
        dismiss(animated: true)
    }
    
    private func string(from slider: UISlider) -> String{
        String(format: "%.02f", slider.value)
    }
    
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setText(for labels: UILabel...) {
        labels.forEach { label in
            switch label.tag {
            case 0: redLabel.text = string(from: redSlider)
            case 1: greenLabel.text = string(from: greenSlider)
            case 2: blueLabel.text = string(from: blueSlider)
            default: break
            }
        }
    }
    
    private func updateSlidersValues() {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
       
        colorView.backgroundColor!.getRed(&red,
                                          green: &green,
                                          blue: &blue,
                                          alpha: &alpha)
        
        redSlider.setValue(Float(red), animated: false)
        greenSlider.setValue(Float(green), animated: false)
        blueSlider.setValue(Float(blue), animated: false)
    }
    
    private func setTextFieldsProperties(for textFields: UITextField...) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let leftSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(keyboardDoneButtonTapped)
        )
        
        toolBar.items = [leftSpace, doneButton]
        
        textFields.forEach { textField in
            switch textField.tag {
            case 0:
                redTextField.delegate = self
                redTextField.text = string(from: redSlider)
                redTextField.inputAccessoryView = toolBar
            case 1:
                greenTextField.delegate = self
                greenTextField.text = string(from: greenSlider)
                greenTextField.inputAccessoryView = toolBar
            case 2:
                blueTextField.delegate = self
                blueTextField.text = string(from: blueSlider)
                blueTextField.inputAccessoryView = toolBar
            default: break
            }
        }
        
    }
    
}

extension ColorSettingsViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard
            var enteredValue = Float(textField.text!)
        else {
            switch textField.tag {
            case 0:
                textField.text = string(from: redSlider)
            case 1:
                textField.text = string(from: greenSlider)
            case 2:
                textField.text = string(from: blueSlider)
            default:
                break
            }
            return
        }
        
        if enteredValue > redSlider.maximumValue {
            enteredValue = redSlider.maximumValue
        }
        
        textField.text = String(format: "%.02f", enteredValue)
        
        switch textField.tag {
        case 0:
            redSlider.setValue(enteredValue, animated: true)
            redLabel.text = string(from: redSlider)
        case 1:
            greenSlider.setValue(enteredValue, animated: true)
            greenLabel.text = string(from: greenSlider)
        case 2:
            blueSlider.setValue(enteredValue, animated: true)
            blueLabel.text = string(from: blueSlider)
        default:
            break
        }
        
        setColor()
    }
    
    @objc private func keyboardDoneButtonTapped() {
        view.endEditing(true)
    }
    
}

