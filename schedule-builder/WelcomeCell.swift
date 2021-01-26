//
//  WelcomeCell.swift
//  schedule-builder
//
//  Created by Thomas Niedzwiadek on 9/19/20.
//

import UIKit

class WelcomeCell: UICollectionViewCell {
    
    //Unwraps our page
    var page: OnboardPage? {
        didSet {
            //Failsafe for page unwrapping
            guard let ourPage = page else {return}
            
            logoView.image = UIImage(named: ourPage.imageString)
            
            
            //Defining our body of text, starting with the header
            let attributedWelcome = NSMutableAttributedString(string: ourPage.headerContents, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25), NSAttributedString.Key.foregroundColor: UIColor.label])
            
            //Appending the body text to the header
            attributedWelcome.append(NSAttributedString(string: "\n\n"+ourPage.bodyContents, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.systemGray]))
            textOpener.attributedText = attributedWelcome
            
            //Text alignment and config
            textOpener.translatesAutoresizingMaskIntoConstraints = false
            textOpener.textAlignment = .center
            textOpener.isEditable = false
            
            //TODO: Consider below?
            textOpener.isScrollEnabled = false
        }
    }
    
    //Closure for the image
    private let logoView: UIImageView = {
        let img =  UIImageView(image: #imageLiteral(resourceName: "SBLogo")) //Default image literal
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    //Defining the textOpener
    private let textOpener: UITextView = {
        let welcomeText = UITextView()
        return welcomeText
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setLayout()
    }
    
    //Setup constraints
    fileprivate func setLayout() {
        let imageContainer = UIView()
        
        //Creating a container to constrain our image
        addSubview(imageContainer)
        
        //Our constraints for the image container
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
        imageContainer.addSubview(logoView)
        
        //Constraining our image to our container
        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
            logoView.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor, constant: 10),
            logoView.heightAnchor.constraint(equalTo: imageContainer.heightAnchor, multiplier: 1),
            logoView.widthAnchor.constraint(equalTo: imageContainer.widthAnchor, multiplier: 0.95)
        ])
        
        addSubview(textOpener)
        //Anchor our welcome text to the container
        NSLayoutConstraint.activate([
            textOpener.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 0),
            textOpener.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textOpener.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//TODO: Adjust font size based on size of screen, or device




//TODO: Fix above constraints, when next changes to start, constraints cause a shift in the navigator (equalCentering has the least noticable effect). If possible, make 3 rectangles and constrain the two furtherest to the edges, and the center to the middle edges of those two. The text should NOT change the shape of the rectangle in this instance
