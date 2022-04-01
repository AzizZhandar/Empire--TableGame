//
//  LastViewController.swift
//  Empire - Table Game
//
//  Created by Mukhamed-Aziz Zhandar on 26.11.2021.
//

import UIKit
import AVFoundation

class LastViewController: UIViewController {
    
    var theme = String()
    var players = String()
    var player = [1, 2, 3, 4, 5]
    var firstElement = Int()
    
    var playerAudio: AVAudioPlayer?
    
    let backgroundView = UIImageView()
    let label = UILabel()
    let buttonLastView = UIButton()
    
    init(playersLastView: String, themeLastView: String) {
        self.players = playersLastView
        self.theme = themeLastView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        styleLastView()
        layoutLastView()
        buttonLastView.addTarget(self, action: #selector(didTapButtonLastView), for: .touchUpInside)
    }
    
// Кнопка - отвечающая за проговорку всех слов, которые были переданы в textfield
    @objc private func didTapButtonLastView() {

        let rootVC = FirstViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)

    }
    
}

extension LastViewController {
    
    func styleLastView() {
        
        player.shuffled()
        firstElement = player[0]
            
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.image = UIImage(named: "wave-haikei-2")
        backgroundView.contentMode = .scaleAspectFill
            
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Игрок №\(firstElement), начинает свой ход"
//            label.backgroundColor = .systemFill
//            label.layer.shadowColor = UIColor.orange.cgColor
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.font = UIFont(name: "Avenir Heavy", size: 20)
        playerNumber += 1
            
            
        buttonLastView.translatesAutoresizingMaskIntoConstraints = false
        buttonLastView.backgroundColor = .link
        buttonLastView.layer.cornerRadius = 15
        buttonLastView.layer.borderWidth = 0.5
        buttonLastView.setTitle("Домой", for: .normal)
        buttonLastView.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        buttonLastView.titleLabel?.font = UIFont(name: "Avenir Heavy", size: 17)


            
    }
    
    func layoutLastView() {
        
        view.addSubview(backgroundView)
        view.addSubview(label)
        view.addSubview(buttonLastView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 30),
            label.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 10),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: label.trailingAnchor, multiplier: 10),
            
            buttonLastView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
            buttonLastView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonLastView.heightAnchor.constraint(equalToConstant: 50),
            buttonLastView.widthAnchor.constraint(equalToConstant: 150)
        
        ])
    }
}
