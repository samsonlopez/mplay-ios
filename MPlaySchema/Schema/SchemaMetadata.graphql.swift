// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public protocol MPlaySchema_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == MPlaySchema.SchemaMetadata {}

public protocol MPlaySchema_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == MPlaySchema.SchemaMetadata {}

public protocol MPlaySchema_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == MPlaySchema.SchemaMetadata {}

public protocol MPlaySchema_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == MPlaySchema.SchemaMetadata {}

public extension MPlaySchema {
  typealias ID = String

  typealias SelectionSet = MPlaySchema_SelectionSet

  typealias InlineFragment = MPlaySchema_InlineFragment

  typealias MutableSelectionSet = MPlaySchema_MutableSelectionSet

  typealias MutableInlineFragment = MPlaySchema_MutableInlineFragment

  enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    public static func objectType(forTypename typename: String) -> Object? {
      switch typename {
      case "Query": return MPlaySchema.Objects.Query
      case "Album": return MPlaySchema.Objects.Album
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}