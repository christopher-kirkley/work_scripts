#!/usr/bin/env python3

import os

templates={
	'12inch': '12inch.pdf',
	'7inch': '7inch.pdf',
	'cassette': 'cassette.pdf',
	'cd': 'digipack.pdf',
	'psd': 'cover.psd',
}

directories={
	'audio': [
		'rough',
		'ddp',
		'wav',
		],
	'art': [
		'lookbook',
		'draft',
		'assets',
		'final',
		],
	'info': [
		'photos',
		'press',
		]
	}

catalog_number = input("catalog number : ").replace(" ", "_")
artist_name = input("artist_name : ").replace(" ", "_")
catalog_name = input("catalog name : ").replace(" ", "_")

if artist_name:
	root = f"{catalog_number}_{artist_name}_{catalog_name}"
else:
	root = f"{catalog_number}_{catalog_name}"

""" Make root directory. """
os.mkdir(root)

for directory in directories:
	path = os.path.join(root, directory)
	# os.mkdir(path)
	for subdir in directories[directory]:
		path = os.path.join(root, directory, subdir)
		os.makedirs(path)


