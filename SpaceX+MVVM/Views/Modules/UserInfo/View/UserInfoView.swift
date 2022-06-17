//
//  UserInfoView.swift
//  SpaceX+MVVM
//
//  Created by Roman Korobskoy on 17.06.2022.
//

import Foundation
import UIKit

class UserInfoView: UIView {
    
    // info labels
    private let firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Фамилия"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.text = "Возраст"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Телефон"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "E-mail"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Пароль"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // dummy labels
    private let firstNameLabelDummy: UILabel = {
        let label = UILabel()
        label.text = "Имя"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondNameLabelDummy: UILabel = {
        let label = UILabel()
        label.text = "Фамилия"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ageLabelDummy: UILabel = {
        let label = UILabel()
        label.text = "Возраст"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneLabelDummy: UILabel = {
        let label = UILabel()
        label.text = "Телефон"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabelDummy: UILabel = {
        let label = UILabel()
        label.text = "E-mail"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordLabelDummy: UILabel = {
        let label = UILabel()
        label.text = "Пароль"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var stackView = UIStackView()
    private var dummyStackView = UIStackView()
    private var mainStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
        setModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        
        mainStackView = UIStackView(arrangedSubviews: [firstNameLabel,
                                                  secondNameLabel,
                                                  ageLabel,
                                                  phoneLabel,
                                                  emailLabel,
                                                  passwordLabel],
                                axis: .vertical,
                                spacing: 10,
                                distribution: .fillProportionally)
        dummyStackView = UIStackView(arrangedSubviews: [firstNameLabelDummy,
                                                        secondNameLabelDummy,
                                                        ageLabelDummy,
                                                        phoneLabelDummy,
                                                        emailLabelDummy,
                                                        passwordLabelDummy],
                                axis: .vertical,
                                spacing: 10,
                                distribution: .fillProportionally)
        stackView = UIStackView(arrangedSubviews: [dummyStackView, mainStackView],
                                axis: .horizontal,
                                spacing: 50,
                                distribution: .fill)
        
        addSubview(stackView)
        stackView.addArrangedSubview(dummyStackView)
        stackView.addArrangedSubview(mainStackView)
    }
    
    private func setModel() {

        let activeUser = UserData.userInfo
        let userInfo = User.data[0]
        
        firstNameLabel.text = activeUser.firstName
        secondNameLabel.text = activeUser.secondName
        emailLabel.text = userInfo.email
        phoneLabel.text = activeUser.phone
        ageLabel.text = activeUser.age
        passwordLabel.text = userInfo.password
    }
}

//MARK: - SetConstraints

extension UserInfoView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
//            stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
