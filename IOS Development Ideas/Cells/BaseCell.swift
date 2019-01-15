//
//  BaseCell.swift
//  IOS Development Ideas
//
//  Created by Work on 11/01/2019.
//  Copyright © 2019 Work. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            if let page = page {
                var imageName = page.imageName

                if UIDevice.current.orientation.isLandscape {
                    //imageName += "_landscape"
                    imageName += ""
                }
                
                imageView.image = UIImage(named: imageName)
                let fontColor = UIColor(white: 0.2, alpha: 1)
                let attributedText = NSMutableAttributedString(string: page.title, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .medium), NSMutableAttributedString.Key.foregroundColor: fontColor])
                attributedText.append(NSAttributedString(string: "\n\n\(page.message)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: fontColor]))
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .center
                
                let length = attributedText.string.count
                
                attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: length))
                
                textView.attributedText = attributedText
            }
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "SAMPLE TEXT FOR NOW"
        tv.isEditable = false
        tv.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        return tv
    }()
    
    let lineSeparatorView: UIView = {
        let v = UIView()
        v.backgroundColor = .red //UIColor(white: 0.9, alpha: 1)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    fileprivate func setupViews() {
        addSubview(imageView)
        addSubview(textView)
        addSubview(lineSeparatorView)
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: lineSeparatorView.topAnchor, trailing: trailingAnchor)
        textView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), size: CGSize(width: 0, height: frame.height * 0.3))
        lineSeparatorView.anchor(top: nil, leading: leadingAnchor, bottom: textView.topAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 3))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
