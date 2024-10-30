//
//  SendModel.swift
//  
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import Foundation

public struct SendModel: Codable {
    public let userData: UserData

    public init(userData: UserData) {
        self.userData = userData
    }
}

// MARK: - UserData
public struct UserData: Codable {
    public let vivisWork: Bool
    public let gfdokPS, gdpsjPjg, poguaKFP: String
    public let gpaMFOfa: [String]
    public let gciOFm: JSONNull?
    public let bcpJFS, gOmblx, g0Pxum: String
    public let fpvbduwm: Bool
    public let fpbjcv: String
    public let stwPp, kDhsd: Bool
    public let bvoikOGjs: JSONNull?
    public let gfpbvjsoM: Int
    public let gfdosnb: JSONNull?
    public let bpPjfns: String
    public let biMpaiuf, oahgoMAOI: Bool

    public init(vivisWork: Bool, gfdokPS: String, gdpsjPjg: String, poguaKFP: String, gpaMFOfa: [String], gciOFm: JSONNull?, bcpJFS: String, gOmblx: String, g0Pxum: String, fpvbduwm: Bool, fpbjcv: String, stwPp: Bool, kDhsd: Bool, bvoikOGjs: JSONNull?, gfpbvjsoM: Int, gfdosnb: JSONNull?, bpPjfns: String, biMpaiuf: Bool, oahgoMAOI: Bool) {
        self.vivisWork = vivisWork
        self.gfdokPS = gfdokPS
        self.gdpsjPjg = gdpsjPjg
        self.poguaKFP = poguaKFP
        self.gpaMFOfa = gpaMFOfa
        self.gciOFm = gciOFm
        self.bcpJFS = bcpJFS
        self.gOmblx = gOmblx
        self.g0Pxum = g0Pxum
        self.fpvbduwm = fpvbduwm
        self.fpbjcv = fpbjcv
        self.stwPp = stwPp
        self.kDhsd = kDhsd
        self.bvoikOGjs = bvoikOGjs
        self.gfpbvjsoM = gfpbvjsoM
        self.gfdosnb = gfdosnb
        self.bpPjfns = bpPjfns
        self.biMpaiuf = biMpaiuf
        self.oahgoMAOI = oahgoMAOI
    }

    enum CodingKeys: String, CodingKey {
        case vivisWork, gfdokPS, gdpsjPjg, poguaKFP, gpaMFOfa, gciOFm
        case bcpJFS = "bcpJFs"
        case gOmblx = "GOmblx"
        case g0Pxum = "G0pxum"
        case fpvbduwm = "Fpvbduwm"
        case fpbjcv = "Fpbjcv"
        case stwPp = "StwPp"
        case kDhsd = "KDhsd"
        case bvoikOGjs, gfpbvjsoM, gfdosnb, bpPjfns, biMpaiuf, oahgoMAOI
    }
}

// MARK: - Encode/decode helpers

public class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
