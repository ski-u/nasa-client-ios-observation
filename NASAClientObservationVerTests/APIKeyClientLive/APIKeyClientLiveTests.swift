import APIKeyClient
import KeychainAccess
import Models
import Testing

@testable import APIKeyClientLive

struct APIKeyClientLiveTests {
    let keychain = Keychain(service: "test")
    
    init() {
        try! keychain.removeAll()
    }
    
    @Test
    func liveValue() {
        let client = APIKeyClient.liveValue(service: "test")
        let key = APIKey(rawValue: "key")
        
        client.setKey(key)
        #expect(client.getKey() == key)
        #expect(client.isKeyStored())
        
        client.setKey(nil)
        #expect(client.getKey() == nil)
        #expect(!client.isKeyStored())
    }
}
