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

## License
- The code (`Library/`, and the programs in `Examples/`) is under the [CeCILL-B](LICENSE) free software license ([version française](LICENSE-fr)), written for French law: use it in any project, open or closed, as long as UI-Toolkit is credited.
- The artwork (`Media/`, `Font/` and the images in `Examples/`) is under [Creative Commons Attribution 4.0](Media/LICENSE).
- `Media/undo.svg` and `Media/redo.svg` are [Material Symbols](https://fonts.google.com/icons) by Google, under the [Apache License 2.0](Media/LICENSE-Apache-2.0).
