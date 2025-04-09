import UIKit
import SnapKit
import Then

class KioskMainController: UIViewController {
    
    private let sharedCartRepository = CartRepository()

    private var menuCartView: MenuCartView!
    private var viewModel: KioskMainViewModel!
    
    private lazy var menuView: MenuView = {
        let view = MenuView()
        view.delegate = self
        return view
    }()
    
    private let contentStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDependencies()
        bindViewModel()
        setStyle()
        setUI()
        setLayout()
    }
    
    private func setupDependencies() {
        viewModel = KioskMainViewModel(
            menuUseCase: MenuUseCase(menuRepository: MenuRepository()),
            cartUseCase: CartUseCase(cartRepository: sharedCartRepository)
        )
        menuCartView = MenuCartView(viewModel: viewModel)
    }
    
    private func bindViewModel() {
        menuView.menuItems = viewModel.getMenuItems().menu[0].items
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

extension KioskMainController: MenuViewDelegate {
    func addCartItem(menuItem item: MenuItem) {
        let cartItem = CartItem(item: item.item, amount: 1)
        viewModel.addCartItem(cartItem, by: 1)
        menuCartView.reloadCart(cartItem)
    }
}
