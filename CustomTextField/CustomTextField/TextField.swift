//
//  TextField.swift
//  CustomTextField
//
//  Created by Anastasia G on 10.02.2022.
//

import UIKit

class TextField: UITextField {
    
    let placeholderLabel = UILabel()
    
    enum PlaceholderState {
        case top
        case bottom
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //тут не работает
        //setUpPlaceholderLabel(state: .bottom)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        borderStyle = .none
        setUpPlaceholderLabel(state: .bottom)
        addTarget(self, action: #selector(didBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(didEnd), for: .editingDidEnd)
    }
    
    @objc func didBegin() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.setUpPlaceholderLabel(state: .top)
        }
        
    }
    
    @objc func didEnd() {
        if let text = self.text, text.isEmpty {
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.setUpPlaceholderLabel(state: .bottom)
            }
        }
    }
    
    func setUpPlaceholderLabel(state: PlaceholderState) {
        switch state {
        case .top:
            placeholderLabel.frame = CGRect(x: 15, y: 8, width: 108, height: 20)
            placeholderLabel.font = UIFont.systemFont(ofSize: 14)
            configureLabel()
        case .bottom:
            placeholderLabel.frame = CGRect(x: 15, y: 25, width: 285, height: 24)
            placeholderLabel.font = UIFont.systemFont(ofSize: 17)
            configureLabel()
        }
        addSubview(placeholderLabel)
    }
    
    func configureLabel() {
        placeholderLabel.textColor = .gray
        placeholderLabel.text = "Код скидки"
    }
}

// MARK: - Inset for text

extension TextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 15, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 15, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
}

// Вот это вот все не работает

extension TextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setUpPlaceholderLabel(state: .top)
        print("up")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            setUpPlaceholderLabel(state: .bottom)
        }
        print("down")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, text.isEmpty {
            setUpPlaceholderLabel(state: .bottom)
        }
        print("smth")
        return true
    }
}
