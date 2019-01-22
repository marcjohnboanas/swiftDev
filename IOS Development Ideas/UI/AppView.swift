//
//  AppView.swift
//  IOS Development Ideas
//
//  Created by Work on 21/01/2019.
//  Copyright © 2019 Work. All rights reserved.
//

import Foundation
import UIKit

class AppView: UIView {
    
    //MARK: Data
    private let appViewType: AppViewType
    var viewModel: AppViewModel
    
    var backgroundType: BackgroundType = .light {
        didSet {
            titleLabel.textColor = backgroundType.titleTextColor
            subtitleLabel.textColor = backgroundType.subtitleTextColor
            buttonSubtitleLabel.textColor = backgroundType.subtitleTextColor
        }
    }
    
    //MARK: UI
    fileprivate var iconImageView = UIImageView()
    fileprivate var titleLabel = UILabel()
    fileprivate var getButton = UIButton(type: UIButton.ButtonType.roundedRect)
    fileprivate var subtitleLabel = UILabel()
    fileprivate var buttonSubtitleLabel = UILabel()
    fileprivate var labelsView = UIView()
    fileprivate var detailsStackView = UIStackView()
    
    init?(_ viewModel: AppViewModel?) {
        guard let viewModel = viewModel else { return nil }
        self.viewModel = viewModel
        self.appViewType = viewModel.appViewType
        super.init(frame: .zero)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        
        configureViews()
        configureLabelsView()
        backgroundColor = .clear
        
        switch appViewType {
        case .horizontal:
            addDetailViews()
        case .featured:
            addFeaturedTopViews()
        case .none:
            break
        }
    }
    
    private func configureViews() {
        iconImageView.configureAppIconView(forImage: viewModel.iconImage, size: appViewType.imageSize)
        
        titleLabel.configureAppHeaderLabel(withText: viewModel.name)
        titleLabel.textColor = backgroundType.titleTextColor
        
        subtitleLabel.configureAppSubHeaderLabel(withText: viewModel.category.description.uppercasedFirstLetter)
        subtitleLabel.textColor = backgroundType.subtitleTextColor
        
        buttonSubtitleLabel.configureTinyLabel(withText: "In-App Purchases")
        buttonSubtitleLabel.textColor = backgroundType.subtitleTextColor
        
        getButton.roundedActionButton(withText: viewModel.appAccess.description)
    }
    
    private func configureLabelsView() {
        
        labelsView.addSubview(subtitleLabel)
        subtitleLabel.pinToSuperview(forAtrributes: [.leading, .width, .bottom])
        
        labelsView.addSubview(titleLabel)
        titleLabel.pinToSuperview(forAtrributes: [.leading, .width, .top])
        titleLabel.pin(attribute: .bottom, toView: subtitleLabel, toAttribute: .top, multiplier: 1.0, constant: -2)
    }
    
    fileprivate func addHorizontalLabelsAndButton() {
        addSubview(labelsView)
        addSubview(getButton)
    }
    
    fileprivate func configureHorizontalLabelsAndButton() {
        labelsView.pinToSuperview(forAtrributes: [.leading, .bottom])
        labelsView.pinToSuperview(forAtrributes: [.width], multiplier: 0.7)
        
        getButton.pinToSuperview(forAtrributes: [.trailing, .bottom])
        getButton.pin(attribute: .width, toView: nil, toAttribute: .notAnAttribute, constant: 76.0)
    }
    
    fileprivate func addPurchaseAvailableLabelIfNeeded() {
        if viewModel.hasInAppPurchase && buttonSubtitleLabel.superview == nil {
            addSubview(buttonSubtitleLabel)
            buttonSubtitleLabel.pin(toView: getButton, attributes: [.centerX])
            buttonSubtitleLabel.pin(attribute: .top, toView: getButton, toAttribute: .bottom, constant: 3.0)
        }
        
        buttonSubtitleLabel.isHidden = !viewModel.hasInAppPurchase
    }
}

//MARK: Featured Top View Layout
extension AppView {
    fileprivate func addFeaturedTopViews() {
        addSubview(iconImageView)
        addHorizontalLabelsAndButton()
        
        configureHorizontalLabelsAndButton()
        configureFeaturedTopViews()
    }
    
    fileprivate func configureFeaturedTopViews() {
        iconImageView.pinToSuperview(forAtrributes: [.top, .leading])
        iconImageView.pin(attribute: .height, toView: nil, toAttribute: .notAnAttribute, constant: appViewType.imageSize)
        iconImageView.pin(attribute: .width, toView: iconImageView, toAttribute: .height)
        configureHorizontalLabelsAndButton()
    }
    
    func configure(with viewModel: AppViewModel) {
        self.viewModel = viewModel
        
        configureViews()
        switch appViewType {
        case .horizontal:
            configureDetailViews()
        case .featured:
            configureFeaturedTopViews()
        case .none:
            break
        }
    }
}

//MARK: Small Detail View Layout
extension AppView {
    fileprivate func addDetailViews() {
        addSubview(iconImageView)
        addSubview(labelsView)
        
        addSubview(getButton)
        configureDetailViews()
    }
    
    fileprivate func configureDetailViews() {
        backgroundColor = .white
        
        iconImageView.pinToSuperview(forAtrributes: [.height], multiplier: 0.7)
        iconImageView.pin(attribute: .width, toView: iconImageView, toAttribute: .height)
        iconImageView.pinToSuperview(forAtrributes: [.leading, .centerY], constant: 0.0)
        
        labelsView.pin(attribute: .leading, toView: iconImageView, toAttribute: .trailing, multiplier: 1.0, constant: 15)
        labelsView.pin(attribute: .trailing, toView: getButton, toAttribute: .leading, multiplier: 1.0, constant: -10)
        labelsView.pinToSuperview(forAtrributes: [.centerY])
        
        getButton.pinToSuperview(forAtrributes: [.centerY])
        getButton.pinToSuperview(forAtrributes: [.trailing], constant: -1.0)
        getButton.pin(attribute: .width, toView: nil, toAttribute: .notAnAttribute, constant: 76.0)
    }
}
