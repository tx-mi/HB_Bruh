//
//  KnownBySquareVC.swift
//  HB_Bruh
//
//  Created by Ramazan Abdulaev on 16.07.2022.
//

import UIKit
import CoreMotion
import SwiftConfettiView

protocol KnownBySquareViewInput: AnyObject {
    func animateSquare()
}

final class KnownBySquareVC: UIViewController, KnownBySquareViewInput {
    typealias KnownInfo = InfoStorage.KnownBySquare
    // MARK: - Properties

    private enum Constants {
        static let verticalInset: CGFloat = 50
        static let horizontalInset: CGFloat = 24
    }
    
    
    var presenter: KnownBySquareViewOutput?
    
    private var isToiletOpen: Bool = false
    private var squareCenterYConstraint: NSLayoutConstraint?
    private var squareOffset: CGFloat?
    
    // MARK: - Views
    
    private let toiletImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.toiletClosed()!
        imageView.animationDuration = 0.6
        imageView.animationRepeatCount = 1
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.animationImages = [
            R.image.toiletOpened()!,
            R.image.toiletHalfOpened()!,
            R.image.toiletClosed()!
        ]
        
        return imageView
    }()

    private let squareImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.squareSilent()!
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.animationDuration = 0.6
        imageView.animationRepeatCount = 0
        imageView.animationImages = [
            R.image.squareSilent()!,
            R.image.squareTalk()!
        ]
        
        return imageView
    }()

    
    private lazy var confettiView: SwiftConfettiView = {
        let view = SwiftConfettiView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.type = .star
        view.intensity = 0.75
        view.isHidden = true
        return view
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.addCoreMotion()
        showSimpleAlert()
    }
    
}

// MARK: - SetupUI

private extension KnownBySquareVC {
    func setupUI() {
        view.backgroundColor = .darkBlueColor
        view.addSubview(squareImageView)
        view.addSubview(toiletImageView)
        view.addSubview(confettiView)
        setupNavBar()
        makeConstraints()
    }
    
    func setupNavBar() {
        title = Quest().fetchQuests()[0].name
        navigationController?.setTitle(with: .sandColor)
        navigationItem.rightBarButtonItem = .init(
            barButtonSystemItem: .bookmarks,
            target: self,
            action: #selector(showSimpleAlert)
        )
    }
    
    func makeConstraints() {
        // рассчет высоты туалета
        let toileghtHeight = view.frame.height / 2 - (2 * Constants.verticalInset)
        // ToiletImage
        NSLayoutConstraint.activate([
            toiletImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.verticalInset),
            toiletImageView.heightAnchor.constraint(equalToConstant: toileghtHeight),
            toiletImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // SquareImage
        NSLayoutConstraint.activate([
            squareImageView.heightAnchor.constraint(equalTo: toiletImageView.heightAnchor, multiplier: 1/4),
            squareImageView.widthAnchor.constraint(equalTo: squareImageView.heightAnchor),
            squareImageView.centerXAnchor.constraint(equalTo: toiletImageView.centerXAnchor),
            
        ])
        // Calc y constraint for square
        squareCenterYConstraint = squareImageView.centerYAnchor.constraint(equalTo: toiletImageView.centerYAnchor, constant: Constants.verticalInset + 5)
        squareCenterYConstraint?.isActive = true
        // Рассчет смещения для анимации квадратика
        squareOffset = view.frame.height - toileghtHeight - view.safeAreaInsets.top

        //Confetti
        NSLayoutConstraint.activate([
            confettiView.topAnchor.constraint(equalTo: view.topAnchor),
            confettiView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            confettiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            confettiView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
}

// MARK: - TapGesture

// For Toilet
private extension KnownBySquareVC {
    func addGesture() {
        let toiletTap = UITapGestureRecognizer()
        let squareTap = UITapGestureRecognizer()
        
        toiletImageView.addGestureRecognizer(toiletTap)
        squareImageView.addGestureRecognizer(squareTap)
        toiletTap.addTarget(self, action: #selector(updateToiletImage(touch:)))
        squareTap.addTarget(self, action: #selector(updateSquareImage))
    }
    
    @objc func updateToiletImage(touch: UITapGestureRecognizer) {
        let touchPoint = touch.location(in: toiletImageView)
        let topEdge = toiletImageView.frame.height / 2 - 10
        let rightEdge = toiletImageView.frame.width / 3
        guard touchPoint.y >= topEdge || touchPoint.x <= rightEdge else { return }
        
        // UpdateImage
        updateStateOfToilet()
    }
    
    
    
}

// MARK: - Animations

extension KnownBySquareVC {
    func updateStateOfToilet() {
        toiletImageView.animationImages?.swapAt(0, 2)
        toiletImageView.startAnimating()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.toiletImageView.image = self.toiletImageView.animationImages?.last!
        }
        isToiletOpen = !isToiletOpen
    }
     
    @objc func updateSquareImage() {
        squareImageView.startAnimating()
        showQuestionAlert()
    }
   
    func animateSquare() {
        // Если квадрат виден, на него можно нажать
        guard isToiletOpen else { return }
        squareImageView.isUserInteractionEnabled = true
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard
                let self = self,
                let constraint = self.squareCenterYConstraint,
                let offset = self.squareOffset
            else { return }
            constraint.constant -= offset
            self.squareOffset = 0
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - UIAlert

private extension KnownBySquareVC {
    @objc func showSimpleAlert() {
        let alertVC = InfoAlertVC(
            title: KnownInfo.SimpleAlert.title,
            message: KnownInfo.SimpleAlert.message
        )
        present(alertVC, animated: true)
    }
    
    func showQuestionAlert() {
        let alertVC = QuestionAlertVC(
            title: KnownInfo.QuestionAlert.title,
            message: KnownInfo.QuestionAlert.message,
            correctAnswer: KnownInfo.QuestionAlert.correctAnswer,
            checkAction: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success():
                    Quest().saveQuest(at: .knownBySquare)
                    self.confettiView.isHidden = false
                    self.confettiView.startConfetti()
                    self.squareImageView.stopAnimating()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        guard self.confettiView.isActive() else { return }
                        self.confettiView.stopConfetti()
                        self.confettiView.isHidden = true
                    }
                case .failure(_):
                    break
                }
            },
            closeAction: { [weak self] in
                guard let self = self, self.squareImageView.isAnimating else { return }
                self.squareImageView.stopAnimating()
            }
        )
        present(alertVC, animated: true)
    }
}

