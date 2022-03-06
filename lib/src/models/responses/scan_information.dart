// Response you get from other clients on the network
class ScanInformation {
  ScanInformation({
    this.lobbyName = '',
    this.connectedPlayers = 0,
    this.maxPlayers = 4,
    this.entryIP = '',
  });

  factory ScanInformation.fromJson(Map<String, dynamic> json) =>
      ScanInformation(
        lobbyName: json['lobbyName'],
        connectedPlayers: json['connectedPlayers'],
        maxPlayers: json['maxPlayers'],
        entryIP: json['entryIP'],
      );

  String lobbyName;
  int connectedPlayers;
  int maxPlayers;
  String entryIP;

  Map<String, dynamic> toJson() => {
        'lobbyName': lobbyName,
        'connectedPlayers': connectedPlayers,
        'maxPlayers': maxPlayers,
        'entryIP': entryIP,
      };  
}
