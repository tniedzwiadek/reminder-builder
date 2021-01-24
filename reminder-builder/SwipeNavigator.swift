//
//  SwipeNavigator.swift
//  reminder-builder
//
//  Created by Thomas Niedzwiadek on 9/19/20.
//

import UIKit

class SwipeNavigator: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    enum CellIds {
        static let welcomeCell = "welcomeCell"
    }
    
    //Declaring our array for the visual contents of each cell during onboarding
    var onboardPages: [OnboardPage] = []
    
    //Our initalizer, sets up the pages and the collection view
    init(collectionViewLayout layout: UICollectionViewLayout, fromSetPages pages: [OnboardPage]) {
        onboardPages = pages
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Our view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeNavigator()
        
        collectionView?.backgroundColor = .systemBackground
        collectionView?.register(WelcomeCell.self, forCellWithReuseIdentifier: CellIds.welcomeCell)
        //Snapping
        collectionView?.isPagingEnabled = true
    }
    
    //Page rotation transitions
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            self.collectionView.reloadData()
            if (self.navigator.currentPage == 0) {
                self.collectionView?.contentOffset = .zero
            }
            else {
                self.collectionView.scrollToItem(at: IndexPath(item: self.navigator.currentPage, section: 0), at: .centeredHorizontally, animated: true)
            }
        }){ (_) in
            //We don't want to do anything specific on completion of the animation, so this is empty
        }

    }

    //Number of cells (returns number of icons in welcomeImages)
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardPages.count
    }
    
    //Dequeues instances of cells, returns a cell with a primary image of the index in welcomeImages equal to the current page. Casts each cell as an intance of WelcomeCell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: CellIds.welcomeCell, for: indexPath) as! WelcomeCell
        
        cell.page = onboardPages[indexPath.item]
        return cell
    }
    
    //Sets navigator page based on manual scrolling
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        //Determines the page value when scrolling ends (full width/width of a cell) and casts to Int
        let endingOfSwipePage = Int((targetContentOffset.pointee.x)/(view.frame.width))
        
        //Handles changing our page
        pageChangeHandler(nextPage: endingOfSwipePage)
    }
    
    //Cell sizes
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    //Spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //Previous button closure
    private let prevButton: UIButton = {
        let leftButton = UIButton(type: .system)
        leftButton.setTitle("Prev", for: .normal)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        leftButton.setTitleColor(.systemBlue, for: .normal)
        leftButton.addTarget(self, action: #selector(prevHandler), for: .touchUpInside)
        return leftButton
    }()
    
    //Handles the previous button functionality
    @objc private func prevHandler() {
        //Our next page will be one before
        let prevPageIndex = navigator.currentPage - 1
        
        //Handles changing our page
        pageChangeHandler(nextPage: prevPageIndex)
        
    }
    //Next button closure
    private let nextButton: UIButton = {
        let rightButton = UIButton(type: .system)
        rightButton.setTitle("Next", for: .normal)
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        rightButton.setTitleColor(.systemBlue, for: .normal)
        rightButton.addTarget(self, action: #selector(nextHandler), for: .touchUpInside)
        return rightButton
    }()
    
    @objc private func nextHandler() {
        //Decides the next index
        let nextPageIndex = (navigator.currentPage + 1) % navigator.numberOfPages

        //Handles changing our page
        pageChangeHandler(nextPage: nextPageIndex)
    }
    
    //Navigator closure
    private lazy var navigator: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = onboardPages.count
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.pageIndicatorTintColor = .gray
        //Calls navigatorHandler to transition page when navigator value changes
        pageControl.addTarget(self, action: #selector(navigatorHandler), for: .valueChanged)
        return pageControl
    }()
    
    //Handles the change in value for touching the navigator
    @objc private func navigatorHandler() {
        //Handles changing our page
        pageChangeHandler(nextPage: navigator.currentPage)
    }
    
    //Handles the functionality of changing the page, when provided with a page to change to
    func pageChangeHandler(nextPage: Int) {
        //Don't want to go back further than the beginning
        if (nextPage < 0) {
            return
        }
        //Scroll to appropriate cell
        collectionView?.scrollToItem(at: IndexPath(item: nextPage, section: 0), at: .centeredHorizontally, animated: true)
        
        //Update the navigator's current page
        navigator.currentPage = nextPage
        
        //If we're at the end, we want to change the next button to Start, otherwise it should be Next
        if (navigator.currentPage == navigator.numberOfPages - 1) {
            nextButton.setTitle("Start", for: .normal)
        }
        else {
            nextButton.setTitle("Next", for: .normal)
        }
       
        //TODO: Implement pressing start bringing you to the main app page, when implemented
    }
    
    //Navigation function
    fileprivate func welcomeNavigator() {
        let bottomStack = UIStackView(arrangedSubviews: [prevButton, navigator, nextButton])
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        //bottomStack.distribution = .fillEqually
        bottomStack.distribution = .equalCentering
        view.addSubview(bottomStack)
        
        //Constraints for the stackView of Prev, Navigator, and Next
        NSLayoutConstraint.activate([
            bottomStack.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.1),
            bottomStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            bottomStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            bottomStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
    }
}

