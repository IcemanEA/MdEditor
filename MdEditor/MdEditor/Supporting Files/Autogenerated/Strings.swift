// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable all

internal enum L10n {

  internal enum About {
    /// about_en
    internal static let file = L10n.tr("Localizable", "About.file")
  }

  internal enum Alert {

    internal enum Button {
      /// Add
      internal static let add = L10n.tr("Localizable", "Alert.Button.add")
      /// Cancel
      internal static let cancel = L10n.tr("Localizable", "Alert.Button.cancel")
      /// OK
      internal static let ok = L10n.tr("Localizable", "Alert.Button.ok")
      /// Save
      internal static let save = L10n.tr("Localizable", "Alert.Button.save")
    }

    internal enum PlaceHolder {
      /// Enter name
      internal static let newDoc = L10n.tr("Localizable", "Alert.PlaceHolder.newDoc")
    }

    internal enum Title {
      /// Error
      internal static let error = L10n.tr("Localizable", "Alert.Title.error")
      /// Warning
      internal static let warning = L10n.tr("Localizable", "Alert.Title.warning")
    }
  }

  internal enum Error {
    /// No information about the app!!! 😔
    internal static let aboutScene = L10n.tr("Localizable", "Error.aboutScene")
    /// Error opening the file: 
    internal static let `open` = L10n.tr("Localizable", "Error.open")
  }

  internal enum FilesManager {

    internal enum Error {
      /// File already exist
      internal static let canNotCreateFileExist = L10n.tr("Localizable", "FilesManager.Error.canNotCreateFileExist")
      /// File not exist
      internal static let fileNotExist = L10n.tr("Localizable", "FilesManager.Error.fileNotExist")
      /// Unknow attributes
      internal static let unKnowAttributes = L10n.tr("Localizable", "FilesManager.Error.unKnowAttributes")
    }
  }

  internal enum Main {
    /// MarkDown editor
    internal static let title = L10n.tr("Localizable", "Main.title")
  }

  internal enum MainMenu {
    /// About application
    internal static let aboutApp = L10n.tr("Localizable", "MainMenu.aboutApp")
    /// New document
    internal static let newDocument = L10n.tr("Localizable", "MainMenu.newDocument")
    /// Open document
    internal static let openDocument = L10n.tr("Localizable", "MainMenu.openDocument")
  }

  internal enum OpenDoc {
    /// Choose storage
    internal static let title = L10n.tr("Localizable", "OpenDoc.title")
  }
}

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
// swiftlint:enable all