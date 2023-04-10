extends AudioStreamPlayer

"""

Music Player is responsible for all music in the game.
Music Player is a global node that persists between scenes.
It also contains a list of all tracks available in the game.

"""

@export var track_list: Array[AudioStream] = []


func start_track(index):
	stream = track_list[index]
	play()
