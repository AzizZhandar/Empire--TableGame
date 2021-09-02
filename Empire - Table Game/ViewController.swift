//
//  ViewController.swift
//  Empire - Table Game
//
//  Created by Mukhamed-Aziz Zhandar on 14.08.2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    let button = UIButton()
    
    
    @IBOutlet weak var firstText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        let utterance = AVSpeechUtterance(string: firstText.text ?? "Nothing")
        utterance.voice = AVSpeechSynthesisVoice(language: "ru-RU")
        utterance.rate = 0.3
        
        let synthesis = AVSpeechSynthesizer()
        synthesis.speak(utterance)
    }
    
}

