# kdry NEWS

## Unreleased (2023-04-18)

#### Other changes

-   update metadata and news.md
    ([6345c67](https://github.com/kapsner/kdry/tree/6345c67aed035169618f2a0b5a34ed33eead44ea))
-   update readme
    ([ef16560](https://github.com/kapsner/kdry/tree/ef1656065cb0a69e6db9a29e9d00008c9f1bfaee))

Full set of changes:
[`v0.0.1...6345c67`](https://github.com/kapsner/kdry/compare/v0.0.1...6345c67)

## v0.0.1 (2023-04-16)

#### Breaking changes

-   rename to mlh\_subset
    ([72f90d4](https://github.com/kapsner/kdry/tree/72f90d4d8ef5a2cc8bcd88fac9a1fa644203781f))

#### New features

-   added pval-helper
    ([6e20f3b](https://github.com/kapsner/kdry/tree/6e20f3ba1e52fd8ff17962ee3a99c8e222121086))
-   added icolnames function
    ([a2de961](https://github.com/kapsner/kdry/tree/a2de9617d3c374e916d88d878d1475b9480d3754))
-   added more reporting tools
    ([bfea7aa](https://github.com/kapsner/kdry/tree/bfea7aabbbac446f5baf2c74d5a599fd71e96964))
-   started adding reporting utilities
    ([75c0289](https://github.com/kapsner/kdry/tree/75c028947289c5824641522cb70e327a5293c498))
-   added mlh\_reshape
    ([e1e835d](https://github.com/kapsner/kdry/tree/e1e835d5ff19aac34145d1abd5f70801bd5a4ddb))
-   added function to fix data types for calculating performance
    measures
    ([215615d](https://github.com/kapsner/kdry/tree/215615def900d10b46aff9b722a6bd8dfbe28efa))
-   added format\_xy
    ([18b0e37](https://github.com/kapsner/kdry/tree/18b0e37e3df2eaaee2caf17553781cd5059a4e96))
-   added list.update
    ([03031a1](https://github.com/kapsner/kdry/tree/03031a16807bbad308f405aebb44d13679148ee6))
-   added check for available cores
    ([9fed377](https://github.com/kapsner/kdry/tree/9fed377d6691eb6dd9298088e278060659078559))
-   added parsing of color arguments to parallel coordinates plot
    ([d043226](https://github.com/kapsner/kdry/tree/d043226211b8dab6dabc9c603de0dc709ce2e976))
-   added plt\_parallel\_coordinates
    ([27a0861](https://github.com/kapsner/kdry/tree/27a0861cca8fc77d3e07d1d0136e5ff6cd1b0341))
-   added list.append
    ([9f80dec](https://github.com/kapsner/kdry/tree/9f80dec219d457bfbf6beb3601d6e4ff11b8178d))
-   added duplicated\_by\_names
    ([3a1dd10](https://github.com/kapsner/kdry/tree/3a1dd10fa68e26d114fab21bcd24ef8f4ab80980))
-   added first general functions
    ([cc13558](https://github.com/kapsner/kdry/tree/cc13558ab12cd383c8ffd6cb123a1660bc0a3f7f))

#### Bug fixes

-   fixed argument name of recursive\_copy
    ([cecbec2](https://github.com/kapsner/kdry/tree/cecbec26ed1d87be0d3bfc60b52893e56e33c6e5))
-   removed scaling of color\_var
    ([3ce00bc](https://github.com/kapsner/kdry/tree/3ce00bc58ba3847c567554c0835f63ba3958d61c))
-   also allowing surv objects in mlh\_subset
    ([4791339](https://github.com/kapsner/kdry/tree/479133999030b58508d2cab461d45ac5e723b985))
-   fixed stopifnot in format\_xy
    ([e726ab2](https://github.com/kapsner/kdry/tree/e726ab2339990172fb6f0ba52e7d4f5e5fd58a62))
-   fix namespace errors with ggplot2
    ([bdbe373](https://github.com/kapsner/kdry/tree/bdbe37380e4a9691ec23a11cb77c217921d6ac1d))
-   fixed logic for returning out-sample ids
    ([28cc902](https://github.com/kapsner/kdry/tree/28cc902e7967fba95a831fa69a143a7f439669a5))
-   removed wronge pkg name
    ([d9a347e](https://github.com/kapsner/kdry/tree/d9a347e6e793def1c0e67bb9ace798584ce3fe5c))

#### Refactorings

-   added interactivity to recursive copying
    ([775fafe](https://github.com/kapsner/kdry/tree/775fafe48976b946586db88518ccc57691c9acb3))
-   removed unnecessary pkg ns check 3
    ([7e47eb4](https://github.com/kapsner/kdry/tree/7e47eb4c3deb0c19b2452b24d9b6ed22d8271099))
-   removed unnecessary pkg ns check 2
    ([eb261ae](https://github.com/kapsner/kdry/tree/eb261ae7ba37a9ff100c54ed087efa6ac9603009))
-   removed unnecessary pkg ns check
    ([4b06602](https://github.com/kapsner/kdry/tree/4b06602d3168e4061ec7afe31c1065729ede7eb3))
-   removed mlh\_fix\_performance\_types
    ([c671a09](https://github.com/kapsner/kdry/tree/c671a09eaf898ebb3169de18d53e444d7b262106))
-   only converting non-factors if necessary
    ([a00b747](https://github.com/kapsner/kdry/tree/a00b7473d2f34f9a3b82c3e39f6522dc41b8b610))
-   refactored argument catcher
    ([0124672](https://github.com/kapsner/kdry/tree/01246724d47d1b123323b95167c459501d7104e2))

#### Docs

-   updated documentation
    ([bb2b489](https://github.com/kapsner/kdry/tree/bb2b48985dab5a1ed8c4232f4debf26d51e723f3))
-   updated example
    ([3fb3fb6](https://github.com/kapsner/kdry/tree/3fb3fb6d7715579f7a59fdc69d43555110da7198))
-   updated examples
    ([e79cf3f](https://github.com/kapsner/kdry/tree/e79cf3f3d25760d7686b597cd16b822314ef3cfb))
-   updated example
    ([e96326a](https://github.com/kapsner/kdry/tree/e96326a9b54314ac1ee384bbbe4cde844c06b6f2))
-   updated readme with installation details
    ([bcf9ebc](https://github.com/kapsner/kdry/tree/bcf9ebc8bc5420b21915c226ae1f6ab52b77a4c6))
-   finishing documentation
    ([d9ab512](https://github.com/kapsner/kdry/tree/d9ab51200e4ac38aa1749167940fd23f84dd397b))
-   working on function documentations
    ([c7213b5](https://github.com/kapsner/kdry/tree/c7213b5a25f097faf8a642dffb55b7a72760db08))
-   started working on documentation; added unit tests
    ([b66666d](https://github.com/kapsner/kdry/tree/b66666dae1ae640f7258d40694ecb0b397561e87))

#### Other changes

-   fixed cran submission
    ([34b5f73](https://github.com/kapsner/kdry/tree/34b5f734fa7557190fa380c09179e014de0f25dd))
-   included cran comments; updated news.md
    ([51ae5f0](https://github.com/kapsner/kdry/tree/51ae5f08f6030fc397f730feed6a023645750735))
-   more informative error messages to stopifnot
    ([ca338fb](https://github.com/kapsner/kdry/tree/ca338fba30c7cf2a504979649d67c9b6a9c542df))
-   working on improving error messages in stopifnot statements
    ([09657e7](https://github.com/kapsner/kdry/tree/09657e794c2fa5fda253ad6da91b9abacf25ef8e))
-   added recursive copying function
    ([b056879](https://github.com/kapsner/kdry/tree/b0568790248f82c087046adb3bfe885a3aed69f0))
-   doparallel and foreach to imports
    ([d350672](https://github.com/kapsner/kdry/tree/d35067255518671e2e2d1347410bfde182e2ebaf))
-   updated documentation
    ([fb7036d](https://github.com/kapsner/kdry/tree/fb7036d5f280c64146a21b1cde4ee51ce4a2721a))
-   updated description and news
    ([b41ca14](https://github.com/kapsner/kdry/tree/b41ca14c7b75f8bed2e60bdb4d0b39b0b88d85b0))
-   updated news.md
    ([812e2c1](https://github.com/kapsner/kdry/tree/812e2c14227a3e693b012666aa5f836478f77233))
-   updated news.md
    ([9d40c37](https://github.com/kapsner/kdry/tree/9d40c37759d1ba5ad8b26dd17192c301b2d2d236))
-   adaptions to new package
    ([d04c5c9](https://github.com/kapsner/kdry/tree/d04c5c968bf2dfeff15adeafe0930850f3257f99))

Full set of changes:
[`41f1eba...v0.0.1`](https://github.com/kapsner/kdry/compare/41f1eba...v0.0.1)
