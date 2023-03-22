/// tool type definition
enum ZegoSuperBoardTool {
  /// There is no setup tool, the functionality normally used for scrolling files
  none, //  (0)
  /// Brush tool, set to draw lines
  pen, //  (1)
  /// Text tool, after setting the pop-up text input box, displayed in the specific position of the whiteboard
  text, //  (2)
  /// Line tool, set to draw a line
  line, //  (4)
  /// Rectangle tool, set to draw a hollow rectangle
  rect, //  (8)
  /// Ellipse tool, set and draw ellipses
  ellipse, //  (16)
  /// Select tool, after setting, you can select the element to operate, such as moving
  selector, //  (32)
  /// Erase tool, after setting, click the image element to erase
  eraser, //  (64)
  /// Laser pointer tool, display laser pointer trajectory after setting
  laser, //  (128)
  /// Click tool, which is mainly used to click the content of dynamic ppt and H5 files
  click, //  (256)
  /// Custom graph, after setting this type, drawing on the whiteboard will draw the custom graph passed by the addImage interface
  customImage, //  (512)
}

/// File type definition
enum ZegoSuperBoardFileType {
  unknown, // (0)
  ppt, // (1)
  doc, // (2)
  els, // (4)
  pdf, // (8)
  img, // (16)
  txt, // (32)
  pdfAndImages, // (256)
  dynamicPPTH5, // (512)
  customH5, // (4096)
}

/// Business scenario: When set to scroll mode, the gesture will be
/// recognized as file scrolling.
/// When set to draw, the gesture is recognized as a function of the drawing tool, such as brush, line, rectangle, etc.
/// Set to None, which will not respond to any gesture.
enum ZegoSuperBoardOperationMode {
  /// Do not respond to any gestures
  none,

  /// Gestures are recognized as functions of drawing tools such as brushes, lines, rectangles, erasers, etc
  draw,

  /// Gestures are recognized as file scrolling
  scroll,

  /// Recognize the zoom gesture; if not set, it will not zoom with the gesture
  zoom,
}
