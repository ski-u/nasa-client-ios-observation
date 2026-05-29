import SwiftUI

struct FullScreenImageView: View {
    let hdImageURL: URL?
    let image: Image
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            if let hdImageURL {
                AsyncImage(url: hdImageURL) { phase in
                    switch phase {
                    case .empty, .failure:
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .overlay {
                                ProgressView()
                            }
                    case let .success(image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    @unknown default:
                        Text("Unexpected error occurred", bundle: .module)
                    }
                }
            } else {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                    }
                    .padding()
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    FullScreenImageView(
        hdImageURL: nil,
        image: Image(systemName: "photo"),
    )
}
