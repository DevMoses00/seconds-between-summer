extends Node

var collected_words := []

func add_word(word: String):
	if not collected_words.has(word):
		collected_words.append(word)
		print("Word added:", word)
