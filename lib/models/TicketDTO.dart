class TicketDTO {
  final String idTicket;
  final String titoloTicket;
  final String path;
  final String nomeFile;

  TicketDTO({
    required this.idTicket,
    required this.titoloTicket,
    required this.path,
    required this.nomeFile,
  });

  factory TicketDTO.fromJson(Map<String, dynamic> json) {
    return TicketDTO(
      idTicket: json['idTicket'] as String,
      titoloTicket: json['titoloTicket'] as String,
      path: json['path'] as String,
      nomeFile: json['nomeFile'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idTicket': idTicket,
      'titoloTicket': titoloTicket,
      'path': path,
      'nomeFile': nomeFile,
    };
  }
}
