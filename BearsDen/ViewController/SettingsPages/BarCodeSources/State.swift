import UIKit

// MARK: - State

/// Barcode scanner state.
enum State {
  case scanning
  case processing
  case unauthorized
  case notFound
}

/// State message provider.
public struct StateMessageProvider {
  public var scanningText = localizedString("Scan barcode")
  public var processingText = localizedString("Looking for your product..")
  public var unathorizedText = localizedString("No authorization")
  public var notFoundText = localizedString("Product not found")

  func makeText(for state: State) -> String {
    switch state {
    case .scanning:
      return scanningText
    case .processing:
      return processingText
    case .unauthorized:
      return unathorizedText
    case .notFound:
      return notFoundText
    }
  }
}

// MARK: - Status

/// Status is a holder of the current state with a few additional configuration properties.
struct Status {
  /// The current state.
  let state: State
  /// Flag to enable/disable animation.
  let animated: Bool
  /// Text that overrides a text from the state.
  let text: String?

  /**
   Creates a new instance of `Status`.
   - Parameter state: State value.
   - Parameter animated: Flag to enable/disable animation.
   - Parameter text: Text that overrides a text from the state.
   */
  init(state: State, animated: Bool = true, text: String? = nil) {
    self.state = state
    self.animated = animated
    self.text = text
  }
}
