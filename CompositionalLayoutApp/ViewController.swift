//
//  ViewController.swift
//  CompositionalLayoutApp
//
//  Created by brubru on 29.11.2024.
//

import UIKit

class ViewController: UIViewController {
	private let reuseIdentifier = "reuseIdentifier"
	private var collectionView: UICollectionView!

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		configureCollectionView()
	}
}

private extension ViewController {
	func setupView() {
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
		collectionView.backgroundColor = .white
		collectionView.dataSource = self
		
		view.addSubview(collectionView)
	}
}

// MARK: - Settings Layout
private extension ViewController {
	func createLayout() -> UICollectionViewLayout {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(0.5), // половина ширины контейнера
			heightDimension: .fractionalHeight(1.0) // высота равная высоте контейнера
		)
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
		
			// Настройка группы
		let groupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(1)
		)
		
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: groupSize,
			repeatingSubitem: item,
			count: 2
		)
		
			// Настройка секции
		let section = NSCollectionLayoutSection(group: group)
		section.orthogonalScrollingBehavior = .continuous // Горизонтальный скроллинг
		section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 5)
		
			// Создание компоновки
		return UICollectionViewCompositionalLayout(section: section)
	}
	
	func configureCollectionView() {
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
}

extension ViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		10
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
		cell.backgroundColor = .systemCyan
		cell.layer.borderColor = UIColor.black.cgColor
		cell.layer.borderWidth = 3
		return cell
	}
}