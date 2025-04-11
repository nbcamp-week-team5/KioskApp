# 프로젝트 소개 
맥도날드 키오스크 UI를 구현

# 기술 스택
- UIKit
- SnapKit
- SwiftLint

# 개발 포인트
- MVVM과 클로저 기반 데이터 바인딩을 이용한 Clean Architecture를 적용하여 확장성 있는 구조로 개발하기
- Git 협업 능력 기르기

# 프로젝트 구조
```
├── App
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Data
│   ├── Factory
│   │   └── MenuDataFactory.swift
│   └── Repositories
│       ├── CartRepository.swift
│       └── MenuRepository.swift
├── Domain
│   ├── Entities
│   │   ├── Cart.swift
│   │   ├── Item.swift
│   │   └── Menu.swift
│   ├── Interfaces
│   │   └── Repositories
│   │       ├── CartRepositoryProtocol.swift
│   │       └── MenuRepositoryProtocol.swift
│   └── UseCases
│       ├── CartUseCase.swift
│       └── MenuUseCase.swift
└── Presentation
    ├── View
    │   ├── CartCell.swift
    │   ├── CartView.swift
    │   ├── CartViewDelegate.swift
    │   ├── CutomSegmentedControl.swift
    │   ├── FooterView.swift
    │   ├── HeaderView.swift
    │   ├── KioskMainViewController.swift
    │   ├── MenuCell.swift
    │   ├── MenuView.swift
    │   └── MenuViewDelegate.swift
    └── ViewModel
        └── KioskMainViewModel.swift
```

# 시연 영상
https://github.com/user-attachments/assets/cb6ab689-124f-4b94-bfa1-5357348c4ee6




