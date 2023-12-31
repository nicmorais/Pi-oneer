#ifndef MUSICTAGPARSER_H
#define MUSICTAGPARSER_H

#include <QString>

class MusicTagParser
{
public:
    explicit MusicTagParser(const QString &);
    explicit MusicTagParser();
    static QString getTitle(const QString &);
    QString getTitle() const;
    static QString getArtist(const QString &);
    QString getArtist() const;
    static QString getAlbum(const QString &);
    QString getAlbum() const;

private:
    QString m_filePath;
};

#endif // MUSICTAGPARSER_H
