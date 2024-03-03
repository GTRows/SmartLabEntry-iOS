//enum APIPath: String {
//    case baseUrl = "https://lab.alperen.keenetic.link"
//
//    // Auth API
//    case registerApi = "/api/v0.1/auth/register"
//
//    // USERS API
//    case getMyUser = "/api/v0.2/users"
//
//    // ACCESS PORTALS API
//    case getAllAccessPortals = "/api/v0.2/access-portals/my-all"
//    case getAccessiblePortals = "/api/v0.2/access-portals"
//    case getPortalStatus = "/api/v0.2/access-portals/portal-status"
//    case enterAccessPortal = "/api/v0.2/access-portals/enter"
//    case exitAccessPortal = "/api/v0.2/access-portals/exit"
//
//    // ADMIN API
//    case getNotVerifiedUsers = "/api/v0.2/admin/not-verified-user"
//    case assignRfid = "/api/v0.2/admin/assign-rfid"
//    case verifiyUser = "/api/v0.2/admin/verify-user"
//    case getAllUsers = "/api/v0.2/users/all"
//    case openDoor = "/api/v0.2/admin/open-access-portal"
//    case onLearningMode = "/api/v0.2/admin/access-portals/on-learning-mode"
//    case offLearningMode = "/api/v0.2/admin/access-portals/off-learning-mode"
//    case getUnknownRfid = "/api/v0.2/admin/access-portals/get-unknown-rfid"
//    case asignUnknownRfid = "/api/v0.2/admin/access-portals/asign-unknown-rfid"
//
//    var urlString: String {
//        switch self {
//        case .baseUrl:
//            return self.rawValue
//        default:
//            return "\(APIPath.baseUrl.rawValue)\(self.rawValue)"
//        }
//    }
//}
