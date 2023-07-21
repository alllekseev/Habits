//
//  HabitCollectionViewController.swift
//  Habits
//
//  Created by Олег Алексеев on 12.07.2023.
//

import UIKit

private let reuseIdentifier = "Cell"

class HabitCollectionViewController: UICollectionViewController {
    var habitsRequestTask: Task<Void, Never>?
    deinit { habitsRequestTask?.cancel() }

    // MARK: defined typealias
    typealias DataSourceType = UICollectionViewDiffableDataSource<ViewModel.Section, ViewModel.Item>

    // MARK: ViewModelEnum
    enum ViewModel {
        enum Section: Hashable, Comparable {
            case favorites
            case category(_ category: Category)

            static func < (lhs: Section, rhs: Section) -> Bool {
                switch (lhs, rhs) {
                case (.category(let left), .category(let right)):
                    return left.name < right.name
                case (.favorites, _):
                    return true
                case (_, .favorites):
                    return false
                }
            }
        }

        typealias Item = Habit
    }

    // MARK: Model Structure
    struct Model {
        var habitsByName = [String: Habit]()
        var favoriteHabits: [Habit] {
            return Settings.shared.favoriteHabits
        }
    }

    // MARK: defined variables
    var dataSource: DataSourceType!
    var model = Model()

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = createDataSource()
        collectionView.dataSource = dataSource
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(NamedSectionHeaderView.self,
                                forSupplementaryViewOfKind: R.Strings.SectionHeader.kind.identifier,
                                withReuseIdentifier: R.Strings.SectionHeader.reuse.identifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        update()
    }

    func update() {
        habitsRequestTask?.cancel()
        habitsRequestTask = Task {
            if let habits = try? await HabitRequest().send() {
                self.model.habitsByName = habits
            } else {
                self.model.habitsByName = [:]
            }
            self.updateCollectionView()

            habitsRequestTask = nil
        }
    }

    func updateCollectionView() {
        var itemsBySection = model.habitsByName.values.reduce(
            into: [ViewModel.Section: [ViewModel.Item]]()) { partial, habit in
                let item = habit
                let section: ViewModel.Section
                if model.favoriteHabits.contains(habit) {
                    section = .favorites
                } else {
                    section = .category(habit.category)
                }

                partial[section, default: []].append(item)
            }

        itemsBySection = itemsBySection.mapValues { $0.sorted() }

        let sectionIDs = itemsBySection.keys.sorted()

        dataSource.applySnapshotUsing(sectionIDs: sectionIDs, itemsBySection: itemsBySection)
    }

    // MARK: createDataSource()
    func createDataSource() -> DataSourceType {
        let dataSource = DataSourceType(collectionView: collectionView) { (collectionView, indexPath, item) in

            let cell = collectionView
                .dequeueReusableCell(
                    withReuseIdentifier: R.Strings.ReuseIdentifier.habit,
                    for: indexPath
                ) as! UICollectionViewListCell

            var content = cell.defaultContentConfiguration()
            content.text = item.name
            cell.contentConfiguration = content

            return cell
        }

        dataSource.supplementaryViewProvider = { (collectionView, _, indexPath) in

            let header = collectionView
                .dequeueReusableSupplementaryView(
                    ofKind: R.Strings.SectionHeader.kind.identifier,
                    withReuseIdentifier: R.Strings.SectionHeader.reuse.identifier,
                    for: indexPath
                ) as! NamedSectionHeaderView

            let section = dataSource.snapshot().sectionIdentifiers[indexPath.section]

            switch section {
            case .favorites:
                header.nameLabel.text = R.Strings.Habits.headerFavorites
            case .category(let category):
                header.nameLabel.text = category.name
            }

            return header

        }

        return dataSource
    }

    // MARK: createLayout()
    func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(44)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       repeatingSubitem: item,
                                                       count: 1)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(36))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: R.Strings.SectionHeader.kind.identifier,
            alignment: .top)
        sectionHeader.pinToVisibleBounds = true

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                        leading: 10,
                                                        bottom: 0,
                                                        trailing: 10)
        section.boundarySupplementaryItems = [sectionHeader]

        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension HabitCollectionViewController {

    override func collectionView(_ collectionView: UICollectionView,
                                 contextMenuConfigurationForItemAt indexPath: IndexPath,
                                 point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let item = self.dataSource.itemIdentifier(for: indexPath)!

            let favoriteToggle = UIAction(
                title: self.model.favoriteHabits.contains(item)
                ? R.Strings.Habits.unfavorite
                : R.Strings.Habits.favorite) { (_) in
                    Settings.shared.toggleFavourite(item)
                    self.updateCollectionView()
                }

            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [favoriteToggle])
        }

        return config
    }

}
