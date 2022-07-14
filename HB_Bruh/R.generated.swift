//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try font.validate()
    try intern.validate()
  }

  /// This `R.color` struct is generated, and contains static references to 1 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentColor.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.file` struct is generated, and contains static references to 2 files.
  struct file {
    /// Resource file `AA Haymaker Regular.ttf`.
    static let aaHaymakerRegularTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "AA Haymaker Regular", pathExtension: "ttf")
    /// Resource file `Archeologicaps.ttf`.
    static let archeologicapsTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Archeologicaps", pathExtension: "ttf")

    /// `bundle.url(forResource: "AA Haymaker Regular", withExtension: "ttf")`
    static func aaHaymakerRegularTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.aaHaymakerRegularTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Archeologicaps", withExtension: "ttf")`
    static func archeologicapsTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.archeologicapsTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.font` struct is generated, and contains static references to 2 fonts.
  struct font: Rswift.Validatable {
    /// Font `AA-Haymaker`.
    static let aaHaymaker = Rswift.FontResource(fontName: "AA-Haymaker")
    /// Font `Archeologicaps`.
    static let archeologicaps = Rswift.FontResource(fontName: "Archeologicaps")

    /// `UIFont(name: "AA-Haymaker", size: ...)`
    static func aaHaymaker(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: aaHaymaker, size: size)
    }

    /// `UIFont(name: "Archeologicaps", size: ...)`
    static func archeologicaps(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: archeologicaps, size: size)
    }

    static func validate() throws {
      if R.font.aaHaymaker(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'AA-Haymaker' could not be loaded, is 'AA Haymaker Regular.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.archeologicaps(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Archeologicaps' could not be loaded, is 'Archeologicaps.ttf' added to the UIAppFonts array in this targets Info.plist?") }
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 5 images.
  struct image {
    /// Image `square-silent`.
    static let squareSilent = Rswift.ImageResource(bundle: R.hostingBundle, name: "square-silent")
    /// Image `square-talk`.
    static let squareTalk = Rswift.ImageResource(bundle: R.hostingBundle, name: "square-talk")
    /// Image `toilet-closed`.
    static let toiletClosed = Rswift.ImageResource(bundle: R.hostingBundle, name: "toilet-closed")
    /// Image `toilet-half-opened`.
    static let toiletHalfOpened = Rswift.ImageResource(bundle: R.hostingBundle, name: "toilet-half-opened")
    /// Image `toilet-opened`.
    static let toiletOpened = Rswift.ImageResource(bundle: R.hostingBundle, name: "toilet-opened")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "square-silent", bundle: ..., traitCollection: ...)`
    static func squareSilent(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.squareSilent, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "square-talk", bundle: ..., traitCollection: ...)`
    static func squareTalk(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.squareTalk, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "toilet-closed", bundle: ..., traitCollection: ...)`
    static func toiletClosed(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.toiletClosed, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "toilet-half-opened", bundle: ..., traitCollection: ...)`
    static func toiletHalfOpened(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.toiletHalfOpened, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "toilet-opened", bundle: ..., traitCollection: ...)`
    static func toiletOpened(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.toiletOpened, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    struct uiApplicationSceneManifest {
      static let _key = "UIApplicationSceneManifest"
      static let uiApplicationSupportsMultipleScenes = false

      struct uiSceneConfigurations {
        static let _key = "UISceneConfigurations"

        struct uiWindowSceneSessionRoleApplication {
          struct defaultConfiguration {
            static let _key = "Default Configuration"
            static let uiSceneConfigurationName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneConfigurationName") ?? "Default Configuration"
            static let uiSceneDelegateClassName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate"

            fileprivate init() {}
          }

          fileprivate init() {}
        }

        fileprivate init() {}
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      // There are no resources to validate
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R {
  fileprivate init() {}
}