import QtQuick 1.1

Item {
    property alias all: allPhotos
    property alias recent: recentPhotos
    property alias favorite: favoritePhotos

    ListModel {
        id: allPhotos

        ListElement {
            image: "../data/photos/t1.jpg"
            fullImage: "../data/photos/c1.jpg"
        }
        ListElement {
            image: "../data/photos/t2.jpg"
            fullImage: "../data/photos/c2.jpg"
        }
        ListElement {
            image: "../data/photos/t3.jpg"
            fullImage: "../data/photos/c3.jpg"
        }
        ListElement {
            image: "../data/photos/t4.jpg"
            fullImage: "../data/photos/c4.jpg"
        }
        ListElement {
            image: "../data/photos/t5.jpg"
            fullImage: "../data/photos/c5.jpg"
        }
        ListElement {
            image: "../data/photos/t6.jpg"
            fullImage: "../data/photos/c6.jpg"
        }
        ListElement {
            image: "../data/photos/t7.jpg"
            fullImage: "../data/photos/c7.jpg"
        }
    }

    ListModel {
        id: recentPhotos

        ListElement {
            image: "../data/photos/t1.jpg"
            fullImage: "../data/photos/c1.jpg"
        }
        ListElement {
            image: "../data/photos/t4.jpg"
            fullImage: "../data/photos/c4.jpg"
        }
        ListElement {
            image: "../data/photos/t7.jpg"
            fullImage: "../data/photos/c7.jpg"
        }
    }

    ListModel {
        id: favoritePhotos

        ListElement {
            image: "../data/photos/t2.jpg"
            fullImage: "../data/photos/c2.jpg"
        }
        ListElement {
            image: "../data/photos/t5.jpg"
            fullImage: "../data/photos/c6.jpg"
        }
        ListElement {
            image: "../data/photos/t7.jpg"
            fullImage: "../data/photos/c7.jpg"
        }
    }
}
