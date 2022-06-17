//
//  AuthView.swift
//  SpaceX+MVVM
//
//  Created by Roman Korobskoy on 17.06.2022.
//

import Foundation
import UIKit

class AuthView: UIView {
    
    private var textFieldsStackView = UIStackView()
    private var buttonsStackView = UIStackView()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
//        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
//        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let scrollView: UIScrollView = { //создаем скроллвью
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false //отключаем авто констрейнты
        return scrollView
    }()
    
    private let backgroundView: UIView = { //настраиваем бэкграунд
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let loginLabel: UILabel = { //настраиваем лейбл
        let label = UILabel()
        label.text = "Log In"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailTextField: UITextField = { //поле почты
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Введите e-mail"
        return textField
    }()
    
    let passwordTextField: UITextField = { //поле пароля
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Введите пароль"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //настраиваем вью
    private func setupViews() {
        backgroundColor = .mainWhite()
        textFieldsStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField],
                                         axis: .vertical,
                                         spacing: 10,
                                         distribution: .fillProportionally)
        
        buttonsStackView = UIStackView(arrangedSubviews: [signInButton,signUpButton],
                                       axis: .vertical,
                                       spacing: 10,
                                       distribution: .fillProportionally)
        
        //добавляем на вью элементы
        addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(textFieldsStackView)
        backgroundView.addSubview(loginLabel)
        backgroundView.addSubview(buttonsStackView)
    }
    
    //назначаем делегатов для полей
    private func setupDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
}

extension AuthView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //убираем клавиатуру по нажатию return в TF
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}

extension AuthView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([
            backgroundView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            backgroundView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            backgroundView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            backgroundView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        NSLayoutConstraint.activate([
            textFieldsStackView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            textFieldsStackView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            textFieldsStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            textFieldsStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            loginLabel.bottomAnchor.constraint(equalTo: textFieldsStackView.topAnchor, constant: -30)
        ])
        NSLayoutConstraint.activate([
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
            signInButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            buttonsStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            buttonsStackView.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 30),
            buttonsStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20)
        ])
    }
}

extension AuthView {
    func update(selector: Selector, target: UIViewController) {
        signInButton.addTarget(target, action: selector, for: .touchUpInside)
    }
}
