import UIKit
import SnapKit
import Then

class KioskMainController: UIViewController {
    
    private let cartRepository: CartRepositoryProtocol = CartRepository()
    private lazy var menuView = MenuView(
        frame: .zero,
        viewModel: KioskMainViewModel(
            menuUseCase: MenuUseCase(menuRepository: MenuRepository()),
            cartUseCase: CartUseCase(cartRepository: cartRepository)
        )
    )
    private lazy var menuCartView = MenuCartView(cartRepository: cartRepository)
    
    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setUI()
        setLayout()
    }
    
    private func setStyle() {
        scrollView.do {
            $0.isScrollEnabled = true
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
        }
        
        contentStack.do {
            $0.axis = .vertical
        }
    }
    
    private func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentStack)
        
        [menuView, menuCartView].forEach {
            contentStack.addArrangedSubview($0)
        }
    }
    
    private func setLayout() {
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        menuView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(500)
        }
        
        menuCartView.snp.makeConstraints {
            $0.top.equalTo(menuView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
    }
}

#Preview {
    KioskMainController()
}
