pragma Singleton
import QtQuick 2.12
import QtQuick.Controls.Material 2.12

Item
{
    id: rootStyle

    property bool isLandscape:false

    property var  defaultPrimaryPalette: style.materialIndigo
    property var  defaultAccentPalette: style.materialPink
    property var  defaultThemePalette: style.darkPalette

    // primary and accent properties:
    property variant primaryPalette: defaultPrimaryPalette
    property color primaryLightColor: primaryPalette[0]
    property color primaryColor: primaryPalette[1]
    property color primaryDarkColor: primaryPalette[2]
    property color textOnPrimaryLight: primaryPalette[3]
    property color textOnPrimary: primaryPalette[4]
    property color textOnPrimaryDark: primaryPalette[5]
    property string iconOnPrimaryLightFolder: primaryPalette[6]
    property string iconOnPrimaryFolder: primaryPalette[7]
    property string iconOnPrimaryDarkFolder: primaryPalette[8]
    property variant accentPalette: defaultAccentPalette
    property color accentColor: accentPalette[0]
    property color textOnAccent: accentPalette[1]
    property string iconOnAccentFolder: accentPalette[2]

    // theme Dark vs Light properties:
    property variant themePalette: defaultThemePalette
    property color dividerColor: themePalette[0]
    property color cardAndDialogBackground: themePalette[1]
    property real primaryTextOpacity: themePalette[2]
    property real secondaryTextOpacity: themePalette[3]
    property real dividerOpacity: themePalette[4]
    property real iconActiveOpacity: themePalette[5]
    property real iconInactiveOpacity: themePalette[6]
    property string iconFolder: themePalette[7]
    property int isDarkTheme: themePalette[8]
    property color flatButtonTextColor: themePalette[9]
    property color popupTextColor: themePalette[10]
    property real toolBarActiveOpacity: themePalette[11]
    property real toolBarInactiveOpacity: themePalette[12]
    property color toastColor: themePalette[13]
    property real toastOpacity: themePalette[14]

    // 5.7: dropShadowColor is ok - the shadow is darker as the background
    // but not so easy to distinguish as in light theme
    // optional:
    // isDarkTheme? "#E4E4E4" : Material.dropShadowColor
    property color dropShadow: Material.dropShadowColor

    onIsDarkThemeChanged: {
        if(isDarkTheme == 1) {
            Material.theme = Material.Dark
        } else {
            Material.theme = Material.Light
        }
    }

    // font sizes - defaults from Google Material Design Guide
    property int fontSizeDisplay4: 112
    property int fontSizeDisplay3: 56
    property int fontSizeDisplay2: 45
    property int fontSizeDisplay1: 34
    property int fontSizeHeadline: 24
    property int fontSizeTitle: 20
    property int fontSizeSubheading: 16
    property int fontSizeBodyAndButton: 14 // is Default
    property int fontSizeCaption: 12
    property int fontSizeActiveNavigationButton: 14
    property int fontSizeInactiveNavigationButton: 12
    // fonts are grouped into primary and secondary with different Opacity
    // to make it easier to get the right property,
    // here's the opacity per size:
    property real opacityDisplay4: secondaryTextOpacity
    property real opacityDisplay3: secondaryTextOpacity
    property real opacityDisplay2: secondaryTextOpacity
    property real opacityDisplay1: secondaryTextOpacity
    property real opacityHeadline: primaryTextOpacity
    property real opacityTitle: primaryTextOpacity
    property real opacitySubheading: primaryTextOpacity
    // body can be both: primary or secondary text
    property real opacityBodyAndButton: primaryTextOpacity
    property real opacityBodySecondary: secondaryTextOpacity
    property real opacityCaption: secondaryTextOpacity
    // using Icons as Toggle to recognize 'checked'
    property real opacityToggleInactive: 0.2
    property real opacityToggleActive: 1.0



    QtObject
    {
        id: style

        property var materialRed : ["#FFCDD2", "#F44336", "#D32F2F", "#000000", "#FFFFFF", "#FFFFFF", "black", "white", "white"]
        property var materialPink : ["#F8BBD0", "#E91E63", "#C2185B", "#000000", "#FFFFFF", "#FFFFFF", "black", "white", "white"]
        property var materialPurple: ["#E1BEE7", "#9C27B0", "#7B1FA2", "#000000", "#FFFFFF", "#FFFFFF", "black", "white", "white"]
        property var materialDeepPurple: ["#D1C4E9", "#673AB7", "#512DA8", "#000000", "#FFFFFF", "#FFFFFF", "black", "white", "white"]
        property var materialIndigo: ["#C5CAE9", "#3F51B5", "#303F9F", "#000000", "#FFFFFF", "#FFFFFF", "black", "white", "white"]
        property var materialBlue: ["#BBDEFB", "#2196F3", "#1976D2", "#000000", "#FFFFFF", "#FFFFFF", "black", "white", "white"]
        property var materialLightBlue: ["#B3E5FC", "#03A9F4", "#0288D1", "#000000", "#FFFFFF", "#FFFFFF", "black", "white", "white"]
        property var materialCyan: ["#B2EBF2", "#00BCD4", "#0097A7", "#000000", "#FFFFFF", "#FFFFFF", "black", "white", "white"]
        property var materialTeal: ["#B2DFDB", "#009688", "#00796B", "#000000", "#FFFFFF", "#FFFFFF", "black", "white", "white"]
        property var materialGreen: ["#C8E6C9", "#4CAF50", "#388E3C", "#000000", "#FFFFFF", "#FFFFFF", "black", "white", "white"]
        property var materialLightGreen: ["#DCEDC8", "#8BC34A", "#689F38", "#000000", "#000000", "#000000", "black", "black", "black"]
        property var materialLime: ["#F0F4C3", "#CDDC39", "#AFB42B", "#000000", "#000000", "#000000", "black", "black", "black"]
        property var materialYellow: ["#FFF9C4", "#FFEB3B", "#FBC02D", "#000000", "#000000", "#000000", "black", "black", "black"]
        property var materialAmber: ["#FFECB3", "#FFC107", "#FFA000", "#000000", "#000000", "#000000", "black", "black", "black"]
        // slightly modified from Material defaults: use white color for primary and primary dark
        property var materialOrange: ["#FFE0B2", "#FF9800", "#F57C00", "#000000", "#FFFFFF", "#FFFFFF", "black", "white", "white"]
        property var materialDeepOrange: ["#FFCCBC", "#FF5722", "#E64A19", "#000000", "#FFFFFF", "#FFFFFF", "black", "white", "white"]
        property var materialBrown: ["#D7CCC8", "#795548", "#5D4037", "#000000", "#FFFFFF", "#FFFFFF", "black", "white", "white"]
        property var materialGrey: ["#F5F5F5", "#9E9E9E", "#616161", "#000000", "#000000", "#FFFFFF", "black", "black", "white"]
        property var materialBlueGrey: ["#CFD8DC", "#607D8B", "#455A64", "#000000", "#FFFFFF", "#FFFFFF", "black", "white", "white"]

        /*
         * T H E M E  Light and Dark  ---  Default: Light
         * Colors, Opacity from Google Material Style Guide
         *
         * QStringList contains:
         * {dividerColor, cardAndDialogBackground, primaryTextOpacity, secondaryTextOpacity, dividerOpacity,
         *    iconActiveOpacity, iconInactiveOpacity, iconFolder, isDark, flatButtonTextColor, popupTextColor,
         *    toolBarActiveOpacity, toolBarInactiveOpacity, toastColor, toastOpacity}
         *
        */
        property var darkPalette: ["#FFFFFF", "#424242", "1.0", "0.70", "0.12", "1.0", "0.3", "white", "1", "#FFFFFF", "#FFFFFF", "1.0", "0.7", "Darkgrey", "0.9"]
        property var lightPalette: ["#000000", "#FFFFFF", "0.87", "0.54", "0.12", "0.54", "0.26", "black", "0", "#424242", "#424242", "1.0", "0.7", "#323232", "0.75"]
    }


    Material.primary: primaryColor
    Material.accent: accentColor

    function setIsLandscape(value) {
        isLandscape = value
    }
}
