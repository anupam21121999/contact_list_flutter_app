
class Contact {
  String name;
  String contact;

  Contact({required this.name, required this.contact});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'number': contact,
    };
  }
}