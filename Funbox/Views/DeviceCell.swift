//
//  DeviceCell.swift
//  Funbox
//
//  Created by Антон Кочетков on 23.11.2021.
//

import UIKit

class DeviceCell: UITableViewCell {

    static let identifier = "DeviceCell"
    
    private var deviceLabel: UILabel = {
        let label = UILabel()
        label.text = "device"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var countLabel: UILabel = {
        let label = UILabel()
        label.text = "count"
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(deviceLabel)
        contentView.addSubview(countLabel)
        setupConstraints()
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(name: String, count: Int) {
        deviceLabel.text = name
        countLabel.text = "\(count) шт."
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            deviceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            deviceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            deviceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            deviceLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.75),
            
            countLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            countLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            countLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            countLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2)])
    }
    
    
}
