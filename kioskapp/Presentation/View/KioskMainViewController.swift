import UIKit
import SnapKit
import Then

class KioskMainController: UIViewController {
    private let cartRepository: CartRepositoryProtocol = CartRepository()
    private lazy var menuCartView = MenuCartView(cartRepository: cartRepository)
    private lazy var menuView = MenuView(
        frame: .zero,
        viewModel: KioskMainViewModel(
            menuUseCase: MenuUseCase(menuRepository: MenuRepository()),
            cartUseCase: CartUseCase(cartRepository: cartRepository)
        ),
        menuCartView: menuCartView
    )
    private lazy var headerView = HeaderView()
    private lazy var footerView = FooterView()
    private let scrollView = UIScrollView()
    
    private let contentStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setUI()
        setLayout()        
    }
    
    private func setStyle() {
        contentStack.do {
            $0.axis = .vertical
            $0.spacing = 10
        }

        scrollView.do {
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.alwaysBounceVertical = true
        }
    }
    
    private func setUI() {
        view.backgroundColor = .white
        view.addSubview(headerView)
                        
        [menuView, menuCartView, footerView].forEach {
            contentStack.addArrangedSubview($0)
        }
        
        scrollView.addSubview(contentStack)
        view.addSubview(scrollView)
    }
    
    private func setLayout() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(2)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        
        contentStack.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        menuView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(400)
        }
        
        menuCartView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(250)
        }
    }
}

#Preview {
    KioskMainController()
}
