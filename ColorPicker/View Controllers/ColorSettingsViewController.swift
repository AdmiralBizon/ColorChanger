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
    var introVCColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        colorView.backgroundColor = introVCColor
        
        updateSlidersValues()
        setText(for: redLabel, greenLabel, blueLabel)
        setTextFieldsProperties(for: redTextField,
                                greenTextField,
                                blueTextField)
        addToolBar(for: redTextField, greenTextField, blueTextField)
        
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
        delegate.setColor(colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    private func string(from slider: UISlider) -> String{
        String(format: "%.2f", slider.value)
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
    
    private func setText(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField.tag {
            case 0: redTextField.text = string(from: redSlider)
            case 1: greenTextField.text = string(from: greenSlider)
            case 2: blueTextField.text = string(from: blueSlider)
            default: break
            }
        }
    }
    
    private func updateSlidersValues() {
        let ciColor = CIColor(color: introVCColor)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    
    private func setTextFieldsProperties(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField.tag {
            case 0:
                redTextField.delegate = self
                setText(for: redTextField)
            case 1:
                greenTextField.delegate = self
                setText(for: greenTextField)
            case 2:
                blueTextField.delegate = self
                setText(for: blueTextField)
            default: break
            }
        }
    }
    
    private func addToolBar(for textFields: UITextField...) {
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
                redTextField.inputAccessoryView = toolBar
            case 1:
                greenTextField.inputAccessoryView = toolBar
            case 2:
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if var currentValue = Float(text) {
        
            if currentValue > redSlider.maximumValue {
                currentValue = redSlider.maximumValue
            }
            
            textField.text = String(format: "%.2f", currentValue)
            
            switch textField.tag {
            case 0:
                redSlider.setValue(currentValue, animated: true)
                redLabel.text = string(from: redSlider)
            case 1:
                greenSlider.setValue(currentValue, animated: true)
                greenLabel.text = string(from: greenSlider)
            case 2:
                blueSlider.setValue(currentValue, animated: true)
                blueLabel.text = string(from: blueSlider)
            default:
                break
            }
            
            setColor()
         
        } else {
            setText(for: textField)
        }
            
    }
    
    @objc private func keyboardDoneButtonTapped() {
        view.endEditing(true)
    }
    
}

