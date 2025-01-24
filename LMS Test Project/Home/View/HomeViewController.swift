//
//  HomeViewController.swift
//  LMS Test Project
//
//  Created by Abdul Motalab Rakib on 20/1/25.
//

import UIKit

class HomeViewController: UIViewController {

    static let identifier = "TeamViewController"
    
    @IBOutlet weak var navLogo: UIBarButtonItem!
    @IBOutlet weak var navNotification: UIBarButtonItem!
    @IBOutlet weak var navMessage: UIBarButtonItem!
    @IBOutlet weak var navSearch: UIBarButtonItem!
    @IBOutlet weak var navBarBGHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var teamCollectionView: UICollectionView! {
        didSet {
            teamCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        }
    }
    
    private let viewModel: HomeViewModel = .init()
    private var lastInactiveTime: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObserver()
        setUpUI()
        setupCollectionView()
        
        handleAPICallback()
    }
    
    func addObserver() {
        // Observe notifications
                NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(appDidEnterBackground),
                    name: UIApplication.didEnterBackgroundNotification,
                    object: nil
                )

                NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(appWillEnterForeground),
                    name: UIApplication.willEnterForegroundNotification,
                    object: nil
                )
    }
    @objc private func appDidEnterBackground() {
            // Save the timestamp when the app enters the background
            lastInactiveTime = Date()
        }

        @objc private func appWillEnterForeground() {
            guard let lastInactiveTime = lastInactiveTime else { return }

            let timeElapsed = Date().timeIntervalSince(lastInactiveTime)
            if timeElapsed >= 10 {
                UserDefaults.standard.setValue(false, forKey: "isLogedIn")
                (UIApplication.shared.delegate as? AppDelegate)?.loadLoginScene()
            }
        }
    deinit {
            NotificationCenter.default.removeObserver(self)
        }
    
    private func setUpUI() {
        if UIDevice.current.hasNotch {
            debugPrint("Device has a notch")
            navBarBGHeightConstraint.constant = 154
        } else {
            debugPrint("Device does not have a notch")
            navBarBGHeightConstraint.constant = 110
        }
        self.navLogo.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 104)
        self.navSearch.imageInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
        self.navMessage.imageInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        self.navNotification.imageInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
    }
    
    private func handleAPICallback() {
//        LoaderManager.shared.showLoader(on: view)
        viewModel.requestForApiData()
        viewModel.callback.complete = {[weak self] in
//            LoaderManager.shared.hideLoader()
            self?.teamCollectionView.reloadData()
        }
    }
    
    private func setupCollectionView() {
        teamCollectionView.backgroundColor = .clear
        teamCollectionView.delegate = self
        teamCollectionView.dataSource = self
        teamCollectionView.contentInset.bottom = 104
        
        teamCollectionView.registerNibCell(TeamDetailsCollectionViewCell.self)
        teamCollectionView.registerNibCell(MatchSummaryCollectionViewCell.self)
        teamCollectionView.registerNibCell(TopPlayerCollectionViewCell.self)
        teamCollectionView.registerNibCell(SquadListContainerCollectionViewCell.self)
        teamCollectionView.registerNibCell(RecentVideosCollectionViewCell.self)
        teamCollectionView.registerNibCell(HonoursAndAwardsCollectionViewCell.self)
        teamCollectionView.registerNibCell(RecentResultsCollectionViewCell.self)
        
        configureCompositionalLayout()
    }
    
    private func configureCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
            switch sectionIndex {
            case 0: 
                return HomeLayout.shared.teamInfoSection()
            case 1:
                return HomeLayout.shared.matchSummarySection()
            case 2:
                return HomeLayout.shared.topPlayerSection()
            case 3:
                return HomeLayout.shared.squadListSection()
            case 4:
                return HomeLayout.shared.recentVideosSection()
            case 5:
                return HomeLayout.shared.honoursSection()
            case 6:
                return HomeLayout.shared.recentResultsSection()
            case 7:
                return HomeLayout.shared.upcomingFixturesSection()
            default:
                return HomeLayout.shared.matchSummarySection()
            }
        }
        teamCollectionView.setCollectionViewLayout(layout, animated: false)
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
//        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel.sections.count
        let sections = viewModel.sections[section]
        switch sections {
        case .teamInfo:
            return 1
        case .matchSummary:
            return 1
        case .topPlayer:
            return viewModel.playerList.count 
        case .squardList:
            return 1
        case .recentVideos:
            return 1
        case .honoursAndAwards:
            return 1
        case .recentResults:
            return 1
        case .upcommingFixtures:
            return 1
        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sections = viewModel.sections[indexPath.section]
        switch sections {
        case .teamInfo:
            let cell =  TeamDetailsCollectionViewCell.dequeue(from: collectionView, at: indexPath)
            cell.teamInfo = viewModel.teamInfoData
            return cell
        case .matchSummary:
            let cell =  MatchSummaryCollectionViewCell.dequeue(from: collectionView, at: indexPath)
            cell.teamStatsData = viewModel.teamStatsData
            cell.teamRankingData = viewModel.teamRankingsData
            return cell
        case .topPlayer:
            let cell =  TopPlayerCollectionViewCell.dequeue(from: collectionView, at: indexPath)
            if indexPath.item == 1 {
                cell.topPlayerCategory = .topBowler
            } else if indexPath.item == 2 {
                cell.topPlayerCategory = .topAllRounder
            }
            cell.playerList = viewModel.playerList[indexPath.item]
            return cell
        case .squardList:
            let cell =  SquadListContainerCollectionViewCell.dequeue(from: collectionView, at: indexPath)
            cell.playerSquadList = viewModel.squadList
            return cell
        case .recentVideos:
            let cell =  RecentVideosCollectionViewCell.dequeue(from: collectionView, at: indexPath)
            cell.viewModel = viewModel
            return cell
        case .honoursAndAwards:
            let cell =  HonoursAndAwardsCollectionViewCell.dequeue(from: collectionView, at: indexPath)
            cell.championShipData = viewModel.championshipData
            return cell
        case .recentResults:
            let cell = RecentResultsCollectionViewCell.dequeue(from: collectionView, at: indexPath)
            cell.headerImageView.image = UIImage(named: "recentResultsBG")
            cell.headerTitleLabel.text = "RECENT RESULTS"
            cell.recentresultsData = viewModel.matchesHistory
            return cell
            
        case .upcommingFixtures:
            let cell =  RecentResultsCollectionViewCell.dequeue(from: collectionView, at: indexPath)
            cell.headerImageView.image = UIImage(named: "upcomingFixtureBG")
            cell.headerTitleLabel.text = "UPCOMING FIXTURES"
            cell.recentresultsData = viewModel.upcomingMatches
            cell.isForUpcomingFixture = true
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

//extension HomeViewController: RecentResultsCollectionViewCellDelegate {
//    // Update height dynamically in cell size
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let sections = viewModel.sections[indexPath.section]
//        switch sections {
//        case .recentResults:
//            // Use the dynamic height or fallback to an estimated height
//            let estimatedHeight = dynamicHeights[indexPath] ?? 240
//            return CGSize(width: collectionView.bounds.width, height: estimatedHeight)
//        default:
//            return CGSize(width: collectionView.bounds.width, height: 240)
//        }
//    }
//}

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: T.reuseID)
    }
    
    func registerNibCell<T: UICollectionViewCell>(_ cellClass: T.Type, nibName: String = T.reuseID) {        
        register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: T.reuseID)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseID, for: indexPath) as? T else {
            fatalError("fatalError: Could not dequeue cell with identifier: \(T.reuseID) for cell at \(indexPath)")
        }
        return cell
    }
}


protocol ReusableView {
    static var reuseID: String { get }
}

extension ReusableView {
    static var reuseID: String {
        return String(describing: Self.self)
    }
}

extension UICollectionViewCell: ReusableView {}
extension UITableViewCell: ReusableView {}
extension UITableViewHeaderFooterView: ReusableView { }
