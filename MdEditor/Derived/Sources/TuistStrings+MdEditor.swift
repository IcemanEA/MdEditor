// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable all

public enum L10n {
  public enum LaunchScreen {
      }
  public enum Localizable {
    
    public enum About {
            /// about_en
        public static let file = L10n.tr("Localizable", "About.file")
          }
  
    public enum Alert {
        
    public enum Button {
            /// Add
        public static let add = L10n.tr("Localizable", "Alert.Button.add")
          /// Cancel
        public static let cancel = L10n.tr("Localizable", "Alert.Button.cancel")
          /// OK
        public static let ok = L10n.tr("Localizable", "Alert.Button.ok")
          /// Save
        public static let save = L10n.tr("Localizable", "Alert.Button.save")
          }
  
    public enum PlaceHolder {
            /// Enter name
        public static let newDoc = L10n.tr("Localizable", "Alert.PlaceHolder.newDoc")
          }
  
    public enum Title {
            /// Error
        public static let error = L10n.tr("Localizable", "Alert.Title.error")
          /// Warning
        public static let warning = L10n.tr("Localizable", "Alert.Title.warning")
          }
      }
  
    public enum Error {
            /// No information about the app!!! 😔
        public static let aboutScene = L10n.tr("Localizable", "Error.aboutScene")
          /// Error opening the file: 
        public static let `open` = L10n.tr("Localizable", "Error.open")
          }
  
    public enum FilesManager {
        
    public enum Error {
            /// File already exist
        public static let canNotCreateFileExist = L10n.tr("Localizable", "FilesManager.Error.canNotCreateFileExist")
          /// File not exist
        public static let fileNotExist = L10n.tr("Localizable", "FilesManager.Error.fileNotExist")
          /// Unknow attributes
        public static let unKnowAttributes = L10n.tr("Localizable", "FilesManager.Error.unKnowAttributes")
          }
      }
  
    public enum Main {
            /// MarkDown editor
        public static let title = L10n.tr("Localizable", "Main.title")
          }
  
    public enum MainMenu {
            /// About application
        public static let aboutApp = L10n.tr("Localizable", "MainMenu.aboutApp")
          /// New document
        public static let newDocument = L10n.tr("Localizable", "MainMenu.newDocument")
          /// Open document
        public static let openDocument = L10n.tr("Localizable", "MainMenu.openDocument")
          }
  
    public enum OpenDoc {
            /// Choose storage
        public static let title = L10n.tr("Localizable", "OpenDoc.title")
          }
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