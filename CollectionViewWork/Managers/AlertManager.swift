//
//  AlertManager.swift
//  CollectionViewWork
//
//  Created by Кирилл Файфер on 08.02.2021.
//

import UIKit

class AlertManager {
    static let shared = AlertManager()
    
    private init () {}
    
    func showActionAlert(title: String, message: String, yesAction: @escaping () -> Void, complitionForPresenting: @escaping (UIAlertController) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Yes", style: .default) { _ in
            yesAction()
        }
        let noAction = UIAlertAction(title: "No", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(noAction)
        
        complitionForPresenting(alert)
    }
    
    func showsimpleAlert(title: String, message: String, complitionForPresenting: @escaping (UIAlertController) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Got it!", style: .default)
        
        alert.addAction(okAction)
        
        complitionForPresenting(alert)
    }
}
