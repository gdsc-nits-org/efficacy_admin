enum Social { github, facebook, instagram, linkedin }

enum Branch { CE, CSE, ECE, EIE, EE, ME }

enum Degree { BTech, MTech, Phd }

enum Permissions {
  /// Can create or edit events
  modifyEvents("Create or Edit events", "Can create or edit events"),

  /// Can add or remove members.
  /// The target here are adding or removing members without touching the club positions
  modifyMembers("Modify Members",
      "Can add or remove members without touching the club positions"),

  /// Can create or modify positions.
  /// This gives them the privilege of editing the clubPositions and club details
  modifyClub("Modify club details",
      "This gives them the privilege of editing the clubPositions and club details");

  final String name;
  final String description;
  const Permissions(this.name, this.description);
}
