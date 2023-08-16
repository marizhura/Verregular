//
//  TrainViewController.swift
//  Verregular
//
//  Created by Марина Журавлева on 10.08.2023.
//

import UIKit
import SnapKit

final class TrainViewController: UIViewController {
    
    private var correctAnswersCount = 0
    
    private var currentVerbIndex: Int = 0
    
    private lazy var verbCountLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.text = ""
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var scoreCountLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.text = "Score:".localized + " \(count)"
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.showsVerticalScrollIndicator = false
        
        return view
    }()
    
    private lazy var contentView: UIView = UIView()
    
    private lazy var infinitiveLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var pastSimpleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Past Simple"
        
        return label
    }()
    
    private lazy var participleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Past Participle"
        
        return label
    }()
    
    private lazy var pastSimpleTextField: UITextField = {
        let field = UITextField()
        
        field.borderStyle = .roundedRect
        field.delegate = self
        
        return field
    }()
    
    private lazy var participleTextField: UITextField = {
        let field = UITextField()
        
        field.borderStyle = .roundedRect
        field.delegate = self
        
        return field
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGray5
        button.setTitle("Check".localized, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(checkAction), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Properties
    private let edgeInsets = 30
    private let dataSource = IrregularVerbs.shared.selectedVerbs
    private var currentVerb: Verb? {
        guard dataSource.count > count else { return nil }
        return dataSource[count]
    }
    private var count = 0 {
        didSet {
            currentVerbIndex = count + 1
            infinitiveLabel.text = currentVerb?.infinitive
            pastSimpleTextField.text = ""
            participleTextField.text = ""
            verbCountLabel.text = "\(currentVerbIndex) / \(dataSource.count)"
            checkButton.backgroundColor = .systemGray5
        }
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Train Verbs".localized
        
        setupUI()
        
        hideKeyboardWhenTappedAround()
        
        infinitiveLabel.text = dataSource.first?.infinitive
        currentVerbIndex = 1
        verbCountLabel.text = "\(currentVerbIndex) из \(dataSource.count)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerForKeyboardNotification()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        unregisterForKeyboardNotification()
    }
    
    // MARK: - Private methods
    
    @objc
    private func checkAction() {
        if checkAnswers() {
            correctAnswersCount += 1
            if currentVerb?.infinitive == dataSource.last?.infinitive {
                let totalSelectedVerbs = dataSource.count
                let totalCorrectAnswers = dataSource.filter { verb in
                    return verb.pastSimple.lowercased() == pastSimpleTextField.text?.lowercased()
                    && verb.participle.lowercased() == participleTextField.text?.lowercased()
                }.count
                showScoreAlert(totalCorrectAnswers, totalSelectedVerbs)
            } else {
                count += 1
                checkButton.backgroundColor = .systemGray5
                checkButton.setTitle("Check".localized, for: .normal)
            }
        } else {
            checkButton.backgroundColor = .systemRed
            checkButton.setTitle("Try again".localized, for: .normal)
        }
        scoreCountLabel.text = "Score: \(correctAnswersCount)"
    }

    
    private func checkAnswers() -> Bool {
        pastSimpleTextField.text?.lowercased() == currentVerb?.pastSimple.lowercased() &&
        participleTextField.text?.lowercased() == currentVerb?.participle.lowercased()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews([
            verbCountLabel,
            scoreCountLabel,
            infinitiveLabel,
            pastSimpleLabel,
            pastSimpleTextField,
            participleLabel,
            participleTextField,
            checkButton])
        
        setupConstraints()
    }
    
    private func showScoreAlert(_ correctAnswers: Int, _ totalSelectedVerbs: Int) {
        let alert = UIAlertController(title: "Training completed".localized,
                                      message: "Your score:".localized +
                                      " \(correctAnswers)" + " out of".localized +
                                      " \(totalSelectedVerbs)",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func setupConstraints() {
        verbCountLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        scoreCountLabel.snp.makeConstraints { make in
            make.top.equalTo(verbCountLabel.snp.bottom).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.size.edges.equalToSuperview()
        }
        
        infinitiveLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(200)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        pastSimpleLabel.snp.makeConstraints { make in
            make.top.equalTo(infinitiveLabel.snp.bottom).offset(60)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        pastSimpleTextField.snp.makeConstraints { make in
            make.top.equalTo(pastSimpleLabel.snp.bottom).offset(10)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        participleLabel.snp.makeConstraints { make in
            make.top.equalTo(pastSimpleTextField.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        participleTextField.snp.makeConstraints { make in
            make.top.equalTo(participleLabel.snp.bottom).offset(10)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(participleTextField.snp.bottom).offset(100)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
    }
}
    // MARK: - UITextFieldDelegate
    extension TrainViewController: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if pastSimpleTextField.isFirstResponder {
                participleTextField.becomeFirstResponder()
            } else {
                scrollView.endEditing(true)
            }
            return true
        }
    }

    // MARK: - Keyboard events
    private extension TrainViewController {
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func unregisterForKeyboardNotification() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        scrollView.contentInset.bottom = frame.height + 50
    }
    
    @objc
    func keyboardWillHide() {
        scrollView.contentInset.bottom = .zero - 50
    }
        
    func hideKeyboardWhenTappedAround() {
            let recognizer = UITapGestureRecognizer(target: self,
                                                    action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(recognizer)
    }
        
    @objc
    func hideKeyboard() {
        scrollView.endEditing(true)
    }
}
