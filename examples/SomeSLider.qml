import Qt 4.7

Templates.VerticalSlider {
    width:20
    height:100
    BorderImage {
        source: "groovecrap.png"
        anchors.fill: parent
    }

    styling: SliderStyling{
        handle: Image {width:32; height:32}
        positionIndicator: Text{}
    }
}

Templates.HorizontalSlider {
    width:100
    height:20
    BorderImage {
        source: "groovecrap_horizontal.png"
        anchors.fill: parent
    }

    styling: SliderStyling{
        handle: Image {width:32; height:32}
        positionIndicator: Text{}
    }
}

Templates.TextField{
    width:100
    height:20
    BorderImage {
        source: "textfield.png"
        anchors.fill: parent
    }
    //textmargins: {left:8; right:8; top:8 ; bottom:8}
}
