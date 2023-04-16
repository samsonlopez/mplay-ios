// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension MPlaySchema {
  class AlbumsQuery: GraphQLQuery {
    public static let operationName: String = "albums"
    public static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query albums($after: String!, $limit: Int!) {
          albums(after: $after, limit: $limit) {
            __typename
            id
            title
            artistId
          }
        }
        """#
      ))

    public var after: String
    public var limit: Int

    public init(
      after: String,
      limit: Int
    ) {
      self.after = after
      self.limit = limit
    }

    public var __variables: Variables? { [
      "after": after,
      "limit": limit
    ] }

    public struct Data: MPlaySchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { MPlaySchema.Objects.Query }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("albums", [Album?]?.self, arguments: [
          "after": .variable("after"),
          "limit": .variable("limit")
        ]),
      ] }

      public var albums: [Album?]? { __data["albums"] }

      /// Album
      ///
      /// Parent Type: `Album`
      public struct Album: MPlaySchema.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { MPlaySchema.Objects.Album }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", MPlaySchema.ID?.self),
          .field("title", String?.self),
          .field("artistId", MPlaySchema.ID?.self),
        ] }

        /// Album ID
        public var id: MPlaySchema.ID? { __data["id"] }
        /// Title
        public var title: String? { __data["title"] }
        /// Artist ID
        public var artistId: MPlaySchema.ID? { __data["artistId"] }
      }
    }
  }

}