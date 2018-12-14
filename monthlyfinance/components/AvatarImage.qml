// org.ingenii.cs
import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import QtGraphicalEffects 1.0


Item {
    id: item

    property alias adapt: image.adapt
    property alias source: image.source
    // image alias
    property alias imageName: image.imageName
    property alias rounded: image.rounded
    property alias fillMode: image.fillMode
    property alias cache : image.cache
    property alias asynchronous : image.asynchronous
    property alias sourceSize : image.sourceSize

    Rectangle {
        id: circleMask
        anchors.fill: parent

        smooth: true
        visible: false

        radius: Math.max(width/2, height/2)
    }

    Image {
        id: image

        property string imageName: ""
        property bool rounded: true
        property bool adapt: true
        visible: false

        onImageNameChanged: {
            if(imageName.length > 0) {
                calculatePath()
            }
        }
        property int imageSize: 0
        onImageSizeChanged: {
            if(imageName.length > 0) {
                calculatePath()
            }
        }
        //trick: to be triggered if folder changed
        property string currentIconFolder: iconFolder
        onCurrentIconFolderChanged: {
            if(imageName.length > 0) {
                calculatePath()
            }
        }
        opacity: iconActiveOpacity
        function calculatePath() {
            var path = "qrc:/images/"+currentIconFolder
            switch(imageSize) {
            case 18:
                path += "/x18/"
                break;
            case 36:
                path += "/x36/"
                break;
            case 48:
                path += "/x48/"
                break;
            default:
                path += "/"
            } // switch
            path += imageName
            source = path
        }

    }

    OpacityMask {
        anchors.fill: parent
        maskSource: circleMask
        source: image
    }

    //    layer.enabled: rounded
    //    layer.effect: ShaderEffect {
    //        property real adjustX: image.adapt ? Math.max(width / height, 1) : 1
    //        property real adjustY: image.adapt ? Math.max(1 / (width / height), 1) : 1

    //        fragmentShader: "
    //        #ifdef GL_ES
    //            precision lowp float;
    //        #endif // GL_ES
    //        varying highp vec2 qt_TexCoord0;
    //        uniform highp float qt_Opacity;
    //        uniform lowp sampler2D source;
    //        uniform lowp float adjustX;
    //        uniform lowp float adjustY;

    //        void main(void) {
    //            lowp float x, y;
    //            x = (qt_TexCoord0.x - 0.5) * adjustX;
    //            y = (qt_TexCoord0.y - 0.5) * adjustY;
    //            float delta = adjustX != 1.0 ? fwidth(y) / 2.0 : fwidth(x) / 2.0;
    //            gl_FragColor = texture2D(source, qt_TexCoord0).rgba
    //                * step(x * x + y * y, 0.25)
    //                * smoothstep((x * x + y * y) , 0.25 + delta, 0.25)
    //                * qt_Opacity;
    //        }"
    //    }
}
