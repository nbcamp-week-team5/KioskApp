import UIKit
import SnapKit
import Then

class KioskMainController: UIViewController {
    
    private let viewModel = KioskMainViewModel(
        menuUseCase: MenuUseCase(menuRepository: MenuRepository()),
        cartUseCase: CartUseCase(cartRepository: CartRepository())
    )
    private lazy var menuView = MenuView(
        viewModel: viewModel,
        menuItems: viewModel.getMenuItems().menu[0].items, cartView: cartView
    )
    private lazy var headerView = HeaderView(viewModel: viewModel)
    private lazy var footerView = FooterView(viewModel: viewModel)
    private let scrollView = UIScrollView()
    private lazy var cartView = CartView(viewModel: viewModel)
    
    private let contentStack = UIStackView()
    
    private var alert: UIAlertController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        footerView.delegate = self
        bindViewModel()
        setStyle()
        setUI()
        setLayout()
    }
    
    private func bindViewModel() {
        viewModel.onCartItemsUpdated = { [weak self] _ in
            guard let self else { return }
            self.cartView.reloadCart()
            self.footerView.reloadAmount()
        }
        
        viewModel.onCategoryUpdated = { [weak self] _ in
            guard let self else { return }
            self.menuView.reloadMenu()
        }
    }
    
    private func setStyle() {
        contentStack.do {
            $0.axis = .vertical
        }
        
        scrollView.do {
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.alwaysBounceVertical = true
        }
        
        footerView.do {
            $0.backgroundColor = .white
            let border = CALayer()
            border.backgroundColor = UIColor.systemGray5.cgColor
            border.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 2)
            $0.layer.addSublayer(border)
        }
    }
    
    private func setUI() {
        view.backgroundColor = .white
        view.addSubview(headerView)
        view.addSubview(scrollView)
        view.addSubview(footerView)
        
        [menuView, cartView].forEach {
            contentStack.addArrangedSubview($0)
        }
        contentStack.setCustomSpacing(18, after: cartView)
        
        scrollView.addSubview(contentStack)
    }
    
    private func setLayout() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(2)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(footerView.snp.top)
        }
        
        contentStack.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        menuView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(400)
        }
        
        cartView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        footerView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(100)
        }
    }
}

extension KioskMainController {
    private func showAlert() {
        guard let alert else { return }
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            self.viewModel.removeAllCartItems()
        }))
        present(alert, animated: true, completion: nil)
    }
}

extension KioskMainController: FooterViewDelegate {
    func didTapPaymentButton() {
        if !viewModel.getCartItems().isEmpty {
            alert = UIAlertController(
                title: "성공",
                message: "상품 주문이 완료되었습니다.",
                preferredStyle: .alert
            )
        } else {
            alert = UIAlertController(
                title: "실패",
                message: "장바구니가 비어있습니다.",
                preferredStyle: .alert
            )
        }
        
        showAlert()
    }
    
    func didTapCancelButton() {
        viewModel.removeAllCartItems()
    }
}
