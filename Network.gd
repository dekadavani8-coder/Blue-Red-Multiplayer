
extends Node

const PORT := 2456
const MAX_PLAYERS := 8

var peer: ENetMultiplayerPeer

func host_game() -> int:
    peer = ENetMultiplayerPeer.new()
    var error := peer.create_server(PORT, MAX_PLAYERS)

    if error != OK:
        return error

    multiplayer.multiplayer_peer = peer
    return OK

func join_game(address: String) -> int:
    peer = ENetMultiplayerPeer.new()
    var error := peer.create_client(address, PORT)

    if error != OK:
        return error

    multiplayer.multiplayer_peer = peer
    return OK

func leave_game() -> void:
    multiplayer.multiplayer_peer = OfflineMultiplayerPeer.new()
