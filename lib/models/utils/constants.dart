enum Social { github, facebook, instagram, linkedin }

enum Branch { CE, CSE, ECE, EIE, EE, ME }

enum Degree { BTech, MTech, Phd }

enum Permission {
  // Only read permission
  // Given to all the users
  read("Read"),
  // Can create or edit events
  modifyEvents("Create or edit Events"),
  // Can add or remove members
  modifyMembers("Modify Members"),
  // Can give or take other members permission
  modifyPermission("Give modify member permissions"),
  // Can create or modify positions
  modifyPositions("Create or modify positions");

  final String name;
  const Permission(this.name);
}
