////
////  ViewController.swift
////  schedule-builder
////
////  Created by Thomas Niedzwiadek on 9/16/20.
////
//
//import UIKit
//
//class ViewController: UIViewController {
//    let label = UILabel()
//    var counter = 0
//    
//    //Closure the logo
//    let logoView: UIImageView = {
//        let logo =  UIImageView(image: #imageLiteral(resourceName: "scheduleBuilderLogo"))
//        logo.translatesAutoresizingMaskIntoConstraints = false
//        logo.contentMode = .scaleAspectFit
//        return logo
//    }()
//    
//    private let prevButton: UIButton = {
//        let leftButton = UIButton(type: .system)
//        leftButton.setTitle("Prev", for: .normal)
//        leftButton.translatesAutoresizingMaskIntoConstraints = false
//        leftButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
//        leftButton.setTitleColor(.gray, for: .normal)
//        return leftButton
//    }()
//    
//    private let nextButton: UIButton = {
//        let rightButton = UIButton(type: .system)
//        rightButton.setTitle("Next", for: .normal)
//        rightButton.translatesAutoresizingMaskIntoConstraints = false
//        rightButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
//        rightButton.setTitleColor(.systemBlue, for: .normal)
//        return rightButton
//    }()
//    
//    private let navigator: UIPageControl = {
//        let pageControl = UIPageControl()
//        pageControl.currentPage = 0
//        pageControl.numberOfPages = 3
//        pageControl.currentPageIndicatorTintColor = .systemBlue
//        pageControl.pageIndicatorTintColor = .gray
//        return pageControl
//    }()
//    
//    let textOpener: UITextView = {
//        let welcomeText = UITextView()
//        let attributedWelcome = NSMutableAttributedString(string: "Welcome to Schedule Builder", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25), NSAttributedString.Key.foregroundColor: UIColor.label])
//        
//        attributedWelcome.append(NSAttributedString(string: "\n\nA simple and easy way to create notifications and reminders", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.systemGray]))
//        
//        welcomeText.attributedText = attributedWelcome
//        welcomeText.translatesAutoresizingMaskIntoConstraints = false
//        welcomeText.textAlignment = .center
//        welcomeText.isEditable = false
//        
//        //TODO: Consider below?
//        welcomeText.isScrollEnabled = false
//        
//        return welcomeText
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(logoView)
//        view.addSubview(textOpener)
//        view.backgroundColor = .systemBackground
//        
//        welcomeNavigator()
//        
//        setLayout()
//        
////        //Creating the button, making it the type of a system button
////        let butt = UIButton(type: .system)
////        butt.setTitle("Memes", for: .normal)
////
////        //Telling our button to look inside of this instance of the ViewController (self) for what to use when the button is pressed (the action, call onMemesPress), when the button is touched (for, when the button is 'touchedUpInside', Up because you're lifting your finger up)
////        butt.addTarget(self, action: #selector(onMemesPress(_:)), for: .touchUpInside)
////
////        //Adds it to the view
////        view.addSubview(butt)
////        view.backgroundColor = .systemBackground
////
////        //Tells iOS we're using our own constraints
////        butt.translatesAutoresizingMaskIntoConstraints = false
////        butt.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
////        butt.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
////
////        view.addSubview(label)
////        label.translatesAutoresizingMaskIntoConstraints = false
////        label.topAnchor.constraint(equalTo: butt.bottomAnchor, constant: 10).isActive = true
////        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
////        label.text = String(counter)
//    
//    }
//    
//    //Setup constraints
//    private func setLayout() {
//        let logoContainer = UIView()
//        
//        //Creating a container to constrain our logo
//        //logoContainer.backgroundColor = .red
//        view.addSubview(logoContainer)
//        
//        
//        logoContainer.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            logoContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            logoContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            logoContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            logoContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
//        ])
//        logoContainer.addSubview(logoView)
//        
//        //Constraining our logo to our container
//        NSLayoutConstraint.activate([
//            logoView.centerXAnchor.constraint(equalTo: logoContainer.centerXAnchor),
//            logoView.centerYAnchor.constraint(equalTo: logoContainer.centerYAnchor, constant: 35),
//            logoView.heightAnchor.constraint(equalTo: logoContainer.heightAnchor, multiplier: 1),
//            logoView.widthAnchor.constraint(equalTo: logoContainer.widthAnchor, multiplier: 0.85)
//        ])
//        
//        //Anchor our welcome text to the container
//        NSLayoutConstraint.activate([
//            textOpener.topAnchor.constraint(equalTo: logoContainer.bottomAnchor, constant: 0),
//            textOpener.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            textOpener.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            
//        ])
//    }
//    
//    fileprivate func welcomeNavigator() {
//        let bottomStack = UIStackView(arrangedSubviews: [prevButton, navigator, nextButton])
//        bottomStack.translatesAutoresizingMaskIntoConstraints = false
//        //bottomStack.distribution = .fillEqually
//        bottomStack.distribution = .fillProportionally
//        view.addSubview(bottomStack)
//        
//        NSLayoutConstraint.activate([
//            bottomStack.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.1),
//            bottomStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            bottomStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
//            bottomStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
//        ])
//    }
////    @objc private func onMemesPress(_ sender: UIButton) {
////        print("whatever")
////        counter += 1
////        label.text = String(counter)
////    }
//
//}
//
