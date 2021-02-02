//
//  Constants.swift
//  CollectionViewWork
//
//  Created by Кирилл Файфер on 28.01.2021.
//

import UIKit

struct Constants {
    static let minimumLineSpacing: CGFloat = 2
    static let minimumLineSpacingHorizontal: CGFloat = 5
    static let minimumItemSpacing: CGFloat = 2
    static let leftDistanceToView: CGFloat = 2
    static let rightDistanceToView: CGFloat = 2
    static let itemWidth: CGFloat = (UIScreen.main.bounds.width - Constants.leftDistanceToView - Constants.rightDistanceToView - Constants.minimumItemSpacing * 3) / 4
    
    static let urlWithKey = "https://api.unsplash.com/photos?client_id=vhZZrxA-4NM8JDe9SItm7jxwpJFSqwSb-nbZ0--75Ck&per_page=32&query="
}
