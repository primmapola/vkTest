//
//  ServiceCell.swift
//  vkTestApp
//
//  Created by Grigory Don on 28.03.2024.
//

import UIKit
import Kingfisher

final class ServiceCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    weak var delegate: ServiceCellDelegate?
    
    let serviceImage = UIImageView()
    private let serviceName = UILabel()
    private let serviceDescription = UILabel()
    private let shimmerView = ShimmerView()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func setupUI() {
        serviceImage.contentMode = .scaleAspectFit
        serviceImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(serviceImage)
        
        serviceName.font = .boldSystemFont(ofSize: 18)
        serviceName.translatesAutoresizingMaskIntoConstraints = false
        addSubview(serviceName)
        
        serviceDescription.font = .systemFont(ofSize: 16)
        serviceDescription.numberOfLines = 0
        serviceDescription.translatesAutoresizingMaskIntoConstraints = false
        addSubview(serviceDescription)
        
        serviceName.textColor = .label
        serviceDescription.textColor = .label
        
        shimmerView.translatesAutoresizingMaskIntoConstraints = false
        shimmerView.isHidden = true
        shimmerView.layer.cornerRadius = 8
        shimmerView.clipsToBounds = true
        shimmerView.backgroundColor = .systemGray5
        serviceImage.addSubview(shimmerView)
        
        NSLayoutConstraint.activate([
            serviceImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            serviceImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            serviceImage.widthAnchor.constraint(equalToConstant: 90),
            serviceImage.heightAnchor.constraint(equalToConstant: 90),
            
            serviceName.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            serviceName.leadingAnchor.constraint(equalTo: serviceImage.trailingAnchor, constant: 10),
            serviceName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            serviceDescription.topAnchor.constraint(equalTo: serviceName.bottomAnchor, constant: 5),
            serviceDescription.leadingAnchor.constraint(equalTo: serviceImage.trailingAnchor, constant: 10),
            serviceDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            serviceDescription.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10),
            
            shimmerView.topAnchor.constraint(equalTo: serviceImage.topAnchor),
            shimmerView.leadingAnchor.constraint(equalTo: serviceImage.leadingAnchor),
            shimmerView.trailingAnchor.constraint(equalTo: serviceImage.trailingAnchor),
            shimmerView.bottomAnchor.constraint(equalTo: serviceImage.bottomAnchor)
        ])
    }
}

// MARK: - Configure

extension ServiceCell {
    func configureWithDisplayData(_ data: ServiceViewModel) {
        serviceName.text = data.name
        serviceDescription.text = data.description

        shimmerView.isHidden = false
        shimmerView.startShimmeringEffect()
        if let imageUrl = data.iconURL {
            serviceImage.kf.setImage(with: imageUrl, placeholder: UIImage(systemName: "photo")) { result in
                self.shimmerView.isHidden = true
                self.shimmerView.stopShimmeringEffect()
            }
        } else {
            serviceImage.image = UIImage(systemName: "photo")
            shimmerView.isHidden = true
            shimmerView.stopShimmeringEffect()
        }
    }

}
