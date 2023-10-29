enum Social { github, facebook, instagram, linkedin }

enum Branch { CE, CSE, ECE, EIE, EE, ME }

enum Degree { BTech, MTech, Phd }

enum Permissions {
  /// Only read permission
  /// Given to all the users
  read("Read"),

  /// Can create or edit events
  modifyEvents("Create or edit Events"),

  /// Can add or remove members.
  /// The target here are adding or removing members without touching the club positions
  modifyMembers("Modify Members"),

  /// Can create or modify positions.
  /// This gives them the privilege of editing the clubPositions and club details
  modifyClub("Modify club details");

  final String name;
  const Permissions(this.name);
}
