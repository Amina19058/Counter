//
//  ViewController.swift
//  Counter
//
//  Created by Amina Khusnutdinova on 06.11.2024.
//

import UIKit

class CounterViewController: UIViewController {
    
    private var counter: Int = 0
    private var currentDateString: String = ""
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var changeLog: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    @IBAction func plusButtonDidTap(_ sender: Any) {
        buttonDidTap(counterAction: .plus)
    }
    
    @IBAction func minusButtonDidTap(_ sender: Any) {
        let isSuccess: Bool = counter > 0
        buttonDidTap(counterAction: .minus(success: isSuccess))
        
    }
    
    @IBAction func resetButtonDidTap(_ sender: Any) {
        buttonDidTap(counterAction: .reset)
    }
    
    // MARK: Private
    
    private func setUpView() {
        counterLabel?.text = "Значение счётчика: \(counter)"
        changeLog?.text = "История изменений:"
        changeLog?.layer.borderColor = UIColor.gray.cgColor
        changeLog?.layer.borderWidth = 1
        changeLog?.layer.cornerRadius = 8
    }
    
    private func buttonDidTap(counterAction: CounterAction) {
        updateCounterAndLabel(counterAction: counterAction)
        updateChangeLog(counterAction: counterAction)
    }
    
    private func updateCounterAndLabel(counterAction: CounterAction) {
        switch counterAction {
        case .reset: 
            counter = 0
        case .plus:
            counter += 1
        case .minus(let isSuccess):
            counter = isSuccess ? counter - 1 : 0
        }
        
        counterLabel?.text = "Значение счётчика: \(counter)"
    }
    
    private func updateChangeLog(counterAction: CounterAction) {
        let currentDateString = Date.now.dateString
        var changeString = ""
        
        switch counterAction {
        case .reset: changeString = "значение сброшено"
        case .plus: changeString = "значение изменено на +1"
        case .minus(let success):
            changeString = success ? "значение изменено на -1" : "попытка уменьшить значение счётчика ниже 0"
        }
        
        let newCounterChangeRecord = "[\(currentDateString)]: \(changeString)"
        
        changeLog?.text += "\n \(newCounterChangeRecord)"
    }
}

private extension Date {
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short

        return dateFormatter.string(from: self)
    }
}

private enum CounterAction {
    case reset
    case plus
    case minus(success: Bool = true)
}
