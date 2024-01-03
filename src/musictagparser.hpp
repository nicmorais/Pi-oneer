#ifndef MUSICTAGPARSER_H
#define MUSICTAGPARSER_H

#include <QString>

class MusicTagParser
{
public:
	explicit MusicTagParser(const QString&);
	static QString getTitle(const QString&);
	static QString getArtist(const QString&);
	static QString getAlbum(const QString&);
};

#endif // MUSICTAGPARSER_H
