import UIKit
import SnapKit
import Then

class KioskMainController: UIViewController {
    
    private let menuView = MenuView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
    }
    
    private func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(menuView)
    }
    
    private func setLayout() {
        menuView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

#Preview {
    KioskMainController()
}
