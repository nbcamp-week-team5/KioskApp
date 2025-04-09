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
        }
    }
    
    private func setUI() {
        view.backgroundColor = .white
                
        view.addSubview(contentStack)
        
        [menuView, menuCartView].forEach {
            contentStack.addArrangedSubview($0)
        }
    }
    
    private func setLayout() {
        
        contentStack.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        menuView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(menuCartView.snp.top)
        }
        
        menuCartView.snp.makeConstraints {
            $0.top.equalTo(menuView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(250)
        }
    }
}

#Preview {
    KioskMainController()
}
