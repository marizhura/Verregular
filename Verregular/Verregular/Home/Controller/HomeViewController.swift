//
//  HomeViewController.swift
//  Verregular
//
//  Created by Марина Журавлева on 07.08.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - GUI Variables
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Verregular".uppercased()
        label.font = .boldSystemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var firstButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Select verbs".localized, for: .normal)
        button .setTitleColor(UIColor.darkText, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.addTarget(self, action: #selector(goToSelectVerbs), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var secondButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Train verbs".localized, for: .normal)
        button .setTitleColor(UIColor.darkText, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.addTarget(self, action: #selector(goToTrainVerbs), for: .touchUpInside)
        
        return button
    }()
    
    
    
    // MARK: - Properties
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Private methods
}

