import UIKit
import SnapKit
import Then

class KioskMainController: UIViewController {
    
    private let viewModel = KioskMainViewModel(
        menuUseCase: MenuUseCase(menuRepository: MenuRepository()),
        cartUseCase: CartUseCase(cartRepository: CartRepository())
    )

    private lazy var menuView = MenuView(viewModel: viewModel)
    private lazy var menuCartView = MenuCartView(viewModel: viewModel)
    
    private let contentStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setStyle()
        setUI()
        setLayout()
    }
    
    private func bindViewModel() {
        menuView.menuItems = viewModel.getMenuItems().menu[0].items
        viewModel.onCartItemsUpdated = { [weak self] _ in
            guard let self else { return }
            self.menuCartView.reloadCart()
        }
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
