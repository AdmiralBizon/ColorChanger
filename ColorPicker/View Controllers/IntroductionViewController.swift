//
//  IntroductionViewController.swift
//  ColorPicker
//
//  Created by Ilya Klimenyuk on 01.11.2020.
//

import UIKit

protocol NewColorViewControllerDelegate {
    func setColor(_ color: UIColor)
}

class IntroductionViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let colorSettingsVC = segue.destination as! ColorSettingsViewController
        colorSettingsVC.delegate = self
        colorSettingsVC.introVCColor = view.backgroundColor ?? .white
    }
    
}

extension IntroductionViewController: NewColorViewControllerDelegate {
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
