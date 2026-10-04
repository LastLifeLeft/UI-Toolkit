<p align="center">
  <img src="https://raw.githubusercontent.com/LastLifeLeft/UI-Toolkit/main/Media/Export/Logo%404x.png" />
</p>

UITK is a collection of canvas gadgets complying with PB's gadget functions.
It works on Windows, Mac and Linux, and requires PB 6.50+.

## Getting started
```purebasic
IncludeFile "Library/UI-Toolkit.pbi"

Window = UITK::Window(#PB_Any, 0, 0, 400, 300, "Hello", UITK::#DarkMode | UITK::#Window_CloseButton | UITK::#Window_ScreenCentered)
UITK::OpenWindowGadgetList(Window)
Button = UITK::Button(#PB_Any, 10, 10, 120, 30, "Click me")
```
Once created, gadgets are driven with PB's own functions (`SetGadgetState`, `AddGadgetItem`, `BindGadgetEvent`...).
TimeLine, LayerList and ParameterList are opt-in: declare an `EnableTimeline`, `EnableLayerList` or `EnableParameterList` module before the include. The `Examples` folder shows every gadget.

## Known limitations
- String has no numeric, password, read-only or maximum-length mode yet.
- FlatMenu has no keyboard navigation or checked items.
- Drag & drop isn't available on Linux.
- In accessibility mode, gadgets with a native PB equivalent fall back to it; the others stay custom.

## Showcase
Here are some projects using UITK :
- ![Icon](https://raw.githubusercontent.com/LastLifeLeft/Inputify/main/Media/Icon/18.png) [Inputify](https://github.com/LastLifeLeft/Inputify), a tool to display your inputs on screen.
- ![Icon](https://lastlife.net/ForumUpload/Abra_Icon.png) [Abra](https://lastlife.net/article?abraCADabra), CAD for people who can't learn normal CAD software.
