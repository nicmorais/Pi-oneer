#include "musictablemodel.hpp"

#include "musictagparser.hpp"
#include "trackmodel.hpp"

#include <QDir>

MusicTableModel::MusicTableModel(QObject* parent) : QAbstractListModel{parent}
{
	m_filesList = m_getFilesList();
}

MusicTableModel::~MusicTableModel()
{
	QAbstractListModel::deleteLater();
}

QVariant MusicTableModel::data(const QModelIndex& index, int role) const
{
	if (role < MusicTableModel::TitleRole) {
		return {};
	}
	int row = index.row();

	if (role == MusicTableModel::TitleRole) {
		return MusicTagParser::getTitle(m_filesList[row]);
	}
	if (role == MusicTableModel::ArtistRole) {
		return MusicTagParser::getArtist(m_filesList[row]);
	}
	if (role == MusicTableModel::AlbumRole) {
		return MusicTagParser::getAlbum(m_filesList[row]);
	}
	if (role == MusicTableModel::PathRole) {
		return m_filesList[row];
	}
	return {};
}

int MusicTableModel::rowCount(const QModelIndex&) const
{
	return m_filesList.count();
}

QHash<int, QByteArray> MusicTableModel::roleNames() const
{
	QHash<int, QByteArray> roles;
	roles.emplace(MusicTableModel::TitleRole, "title");
	roles.emplace(MusicTableModel::ArtistRole, "artist");
	roles.emplace(MusicTableModel::AlbumRole, "album");
	roles.emplace(MusicTableModel::PathRole, "path");

	return roles;
}

QModelIndex MusicTableModel::index(
	int row, int column, const QModelIndex& parent) const
{
	return createIndex(row, column, nullptr);
}

QList<QString> MusicTableModel::m_getFilesList()
{
	QDir dir = QDir::home();
	dir.setPath(dir.absolutePath() + "/Music");
	dir.setFilter(QDir::Files | QDir::NoSymLinks | QDir::NoDotAndDotDot);
	dir.setSorting(QDir::Name);

	QList<QString> l;
	QFileInfoList list = dir.entryInfoList();
	for (const auto& f : list) {
		if (f.suffix() != "mp3") {
			continue;
		}
		l.append(f.absoluteFilePath());
	}
	return l;
}

TrackModel MusicTableModel::getAtIndex(int row) const
{
	auto title = MusicTagParser::getTitle(m_filesList[row]);
	auto artist = MusicTagParser::getArtist(m_filesList[row]);
	//	auto album = MusicTagParser::getAlbum(m_filesList[row]);

	TrackModel track;
	track.setTitle(title);
	track.setArtist(artist);
	track.setPath(m_filesList[row]);

	return track;
}
