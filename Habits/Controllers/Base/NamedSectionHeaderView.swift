//
//  NamedSectionHeaderView.swift
//  Habits
//
//  Created by Олег Алексеев on 14.07.2023.
//

import UIKit

class NamedSectionHeaderView: UICollectionReusableView {
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = R.Font.systemBold(with: 17)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .systemGray5
        
        // TODO: make base class with this properties
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
