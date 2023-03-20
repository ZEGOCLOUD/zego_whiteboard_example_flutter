import 'zego_super_board_defines.dart';

extension ZegoSuperBoardToolExtension on ZegoSuperBoardTool {
  int get id {
    switch (this) {
      case ZegoSuperBoardTool.none:
        return 0;
      case ZegoSuperBoardTool.pen:
        return 1;
      case ZegoSuperBoardTool.text:
        return 2;
      case ZegoSuperBoardTool.line:
        return 4;
      case ZegoSuperBoardTool.rect:
        return 8;
      case ZegoSuperBoardTool.ellipse:
        return 16;
      case ZegoSuperBoardTool.selector:
        return 32;
      case ZegoSuperBoardTool.eraser:
        return 64;
      case ZegoSuperBoardTool.laser:
        return 128;
      case ZegoSuperBoardTool.click:
        return 256;
      case ZegoSuperBoardTool.customImage:
        return 512;
    }
  }

  static const valueMap = {
    0: ZegoSuperBoardTool.none,
    1: ZegoSuperBoardTool.pen,
    2: ZegoSuperBoardTool.text,
    4: ZegoSuperBoardTool.line,
    8: ZegoSuperBoardTool.rect,
    16: ZegoSuperBoardTool.ellipse,
    32: ZegoSuperBoardTool.selector,
    64: ZegoSuperBoardTool.eraser,
    128: ZegoSuperBoardTool.laser,
    256: ZegoSuperBoardTool.click,
    512: ZegoSuperBoardTool.customImage,
  };
}

extension ZegoSuperBoardFileTypeExtension on ZegoSuperBoardFileType {
  int get id {
    switch (this) {
      case ZegoSuperBoardFileType.unknown:
        return 0;
      case ZegoSuperBoardFileType.ppt:
        return 1;
      case ZegoSuperBoardFileType.doc:
        return 2;
      case ZegoSuperBoardFileType.els:
        return 4;
      case ZegoSuperBoardFileType.pdf:
        return 8;
      case ZegoSuperBoardFileType.img:
        return 16;
      case ZegoSuperBoardFileType.txt:
        return 32;
      case ZegoSuperBoardFileType.pdfAndImages:
        return 256;
      case ZegoSuperBoardFileType.dynamicPPTH5:
        return 512;
      case ZegoSuperBoardFileType.customH5:
        return 4096;
    }
  }

  static const valueMap = {
    0: ZegoSuperBoardFileType.unknown,
    1: ZegoSuperBoardFileType.ppt,
    2: ZegoSuperBoardFileType.doc,
    4: ZegoSuperBoardFileType.els,
    8: ZegoSuperBoardFileType.pdf,
    16: ZegoSuperBoardFileType.img,
    32: ZegoSuperBoardFileType.txt,
    256: ZegoSuperBoardFileType.pdfAndImages,
    512: ZegoSuperBoardFileType.dynamicPPTH5,
    4096: ZegoSuperBoardFileType.customH5,
  };
}
