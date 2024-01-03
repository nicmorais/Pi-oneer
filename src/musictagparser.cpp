#include "musictagparser.hpp"

#include <id3/id3lib_streams.h>
#include <id3/misc_support.h>
#include <id3/tag.h>

MusicTagParser::MusicTagParser(const QString& filePath) {}

QString MusicTagParser::getTitle(const QString& filePath)
{
	ID3_Tag tag(filePath.toStdString().c_str());
	const ID3_Frame* frame = tag.Find(ID3FID_TITLE);
	if (frame) {
		return QString::fromStdString(std::string{ID3_GetTitle(&tag)});
	}
	return filePath;
}

QString MusicTagParser::getArtist(const QString& filePath)
{
	ID3_Tag tag(filePath.toStdString().c_str());
	const ID3_Frame* frame = tag.Find(ID3FID_LEADARTIST);
	if (frame) {
		return QString::fromStdString(std::string{ID3_GetArtist(&tag)});
	}
	return "Unknown Artist";
}

QString MusicTagParser::getAlbum(const QString& filePath)
{
	ID3_Tag tag(filePath.toStdString().c_str());
	const ID3_Frame* frame = tag.Find(ID3FID_ALBUM);
	if (frame) {
		return QString::fromStdString(std::string{ID3_GetAlbum(&tag)});
	}
	return "Unknown Album";
}
