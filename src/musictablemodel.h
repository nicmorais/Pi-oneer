#ifndef MUSICTABLEMODEL_H
#define MUSICTABLEMODEL_H

#include <QAbstractItemModel>
#include <QObject>

class MusicTableModel : public QAbstractListModel
{
    Q_OBJECT
public:
    MusicTableModel(QObject *parent = nullptr);
    ~MusicTableModel();
    QVariant data(const QModelIndex &, int role = Qt::DisplayRole) const override;
    int rowCount(const QModelIndex &) const override;
    QModelIndex index(int, int, const QModelIndex &parent = QModelIndex()) const override;
    QHash<int, QByteArray> roleNames() const override;
    enum Role {
        TitleRole = 20,
        ArtistRole = 21,
        AlbumRole = 22,
    };

private:
    QList<QString> m_getFilesList();
    QList<QString> m_filesList;
};

#endif // MUSICTABLEMODEL_H
