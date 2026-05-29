import Foundation
import LocalDate

public struct AstronomyPicture: Equatable, Sendable {
    public var copyright: String?
    public var date: LocalDate
    public var explanation: String
    public var hdURL: URL?
    public var mediaType: MediaType
    public var title: String
    public var url: URL?
    
    public init(
        copyright: String? = nil,
        date: LocalDate,
        explanation: String,
        hdURL: URL? = nil,
        mediaType: MediaType,
        title: String,
        url: URL? = nil,
    ) {
        self.copyright = copyright
        self.date = date
        self.explanation = explanation
        self.hdURL = hdURL
        self.mediaType = mediaType
        self.title = title
        self.url = url
    }
    
    public init(payload: Payload) {
        self.init(
            copyright: payload.copyright,
            date: try! LocalDate(from: payload.date),
            explanation: payload.explanation,
            hdURL: payload.hdURL.map { URL(string: $0)! },
            mediaType: MediaType(string: payload.mediaType),
            title: payload.title,
            url: payload.url.map { URL(string: $0)! },
        )
    }
}

extension AstronomyPicture {
    public struct Payload: Decodable {
        public var copyright: String?
        public var date: String
        public var explanation: String
        public var hdURL: String?
        public var mediaType: String
        public var title: String
        public var url: String?
        
        public init(
            copyright: String? = nil,
            date: String,
            explanation: String,
            hdURL: String? = nil,
            mediaType: String,
            title: String,
            url: String? = nil,
        ) {
            self.copyright = copyright
            self.date = date
            self.explanation = explanation
            self.hdURL = hdURL
            self.mediaType = mediaType
            self.title = title
            self.url = url
        }
        
        enum CodingKeys: String, CodingKey {
            case copyright
            case date
            case explanation
            case hdURL = "hdurl"
            case mediaType = "media_type"
            case title
            case url
        }
    }
}

#if DEBUG
extension AstronomyPicture {
    public static let mock = Self(
        copyright: "Bray FallsKeith Quattrocchi",
        date: .init(year: 2012, month: 7, day: 12),
        explanation:
            "What will become of our Sun? The first hint of our Sun's future was discovered inadvertently in 1764. At that time, Charles Messier was compiling a list of diffuse objects not to be confused with comets. The 27th object on Messier's list, now known as M27 or the Dumbbell Nebula, is a planetary nebula, one of the brightest planetary nebulae on the sky -- and visible toward the constellation of the Fox (Vulpecula) with binoculars. It takes light about 1000 years to reach us from M27, featured here in colors emitted by hydrogen and oxygen. We now know that in about 6 billion years, our Sun will shed its outer gases into a planetary nebula like M27, while its remaining center will become an X-ray hot white dwarf star.  Understanding the physics and significance of M27 was well beyond 18th century science, though. Even today, many things remain mysterious about planetary nebulas, including how their intricate shapes are created.",
        hdURL: .init(
            string: "https://apod.nasa.gov/apod/image/2107/M27_Falls_3557.jpg"
        )!,
        mediaType: .image,
        title: "M27: The Dumbbell Nebula",
        url: .init(string: "https://apod.nasa.gov/apod/image/2107/M27_Falls_960.jpg")!,
    )
}
#endif
