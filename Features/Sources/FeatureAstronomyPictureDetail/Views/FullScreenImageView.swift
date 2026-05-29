import Kingfisher
import SwiftUI

struct FullScreenImageView: View {
    let hdImageURL: URL?
    let image: Image
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            if let hdImageURL {
                KFImage(hdImageURL)
                    .placeholder {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .overlay {
                                ProgressView()
                            }
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
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
