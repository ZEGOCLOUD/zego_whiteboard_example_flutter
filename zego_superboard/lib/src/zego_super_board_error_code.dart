enum ZegoSuperBoardError {
  /// Success
  success,

  /// Internal error
  internal,

  /// Invalid parameter. Please check the specific information output to the console.
  paramInvalid,

  /// Network timeout
  networkTimeout,

  /// Network disconnected
  networkDisconnect,

  /// Network packet error
  response,

  /// Request too frequent
  requestTooFrequent,

  /// Initialization failed. Please use the ZegoExpress-Video SDK version
  /// that matches the Whiteboard.
  versionMismatch,

  /// Initialization failed. Please use the ZegoExpress-Video SDK that
  /// contains the Whiteboard feature.
  expressImcompatible,

  /// Not logged into the room
  noLoginRoom,

  /// Whiteboard view does not exist
  viewNotExist,

  /// Failed to create whiteboard view
  viewCreateFail,

  /// Failed to modify whiteboard view
  viewModifyFail,

  /// Whiteboard view name is too long
  viewNameLimit,

  /// The parent of the whiteboard view does not exist
  viewParentNotExist,

  /// Exceeded the maximum number of whiteboards allowed
  viewNumLimit,

  /// Animation information is too long
  animationInfoLimit,

  /// The graphic element does not exist
  graphicNotExist,

  /// Failed to create graphic element
  graphicCreateFail,

  /// Failed to modify graphic element
  graphicModifyFail,

  /// Drawing not enabled
  graphicUnableDraw,

  /// The size of a single graphic element data exceeds the limit
  graphicDataLimit,

  /// Exceeded the maximum number of graphic elements allowed
  graphicNumLimit,

  /// The text exceeds the maximum number of characters
  graphicTextLimit,

  /// The size of the graphic image exceeds the limit.
  graphicImageSizeLimit,

  /// Unsupported image type.
  graphicImageTypeNotSupport,

  /// Invalid image address, possible reasons include: invalid network URL
  /// when specifying an image, invalid local path when specifying an image.
  graphicIllegalAddress,

  /// Initialization failed.
  initFail,

  /// Failed to retrieve the list of whiteboard views.
  getListFail,

  /// Failed to create a whiteboard view.
  createFail,

  /// Failed to destroy a whiteboard view.
  destroyFail,

  /// attach whiteboard view failed
  attachFail,

  /// clear whiteboard view failed
  clearFail,

  /// scroll whiteboard view failed
  scrollFail,

  /// undo operation failed
  undoFail,

  /// redo operation failed
  redoFail,

  /// the log directory set during initialization cannot be created or written to
  logFolderNotAccess,

  /// the cache directory set during initialization cannot be created or written to
  cacheFolderNotAccess,

  /// switch whiteboard view failed
  switchFail,

  /// no permission to scale whiteboard
  noAuthScale,

  /// no permission to scroll whiteboard
  noAuthScroll,

  /// no permission to create graphic elements
  noAuthCreateGraphic,

  /// no permission to edit graphic elements
  noAuthUpdateGraphic,

  /// no permission to move whiteboard
  noAuthMoveGraphic,

  /// no permission to delete whiteboard
  noAuthDeleteGraphic,

  /// no permission to clear whiteboard
  noAuthClearGraphic,

  /// the corresponding local file cannot be found, possible reasons
  /// include: accessing the wrong file path during upload. The local file has been deleted.
  fileNotExist,

  /// upload failed
  uploadFailed,

  /// unsupported rendering mode
  unsupportRenderType,

  /// the file that needs to be transcoded is encrypted, possible reasons
  /// include: Word file access requires a password. Excel file access requires a password. PPT file access requires a password.
  fileEncrypt,

  /// the file content is too large, possible reasons include: Excel file
  /// size exceeds 10 MB. Excel file opening time is too long. Text file size exceeds 2 MB. Other file size exceeds 100 MB.
  fileSizeLimit,

  /// the number of pages in the file is too many, possible reasons
  /// include: the number of sheets in the Excel file exceeds 20. The number of pages in Word file exceeds 500. The number of pages in PPT file exceeds 500.
  fileSheetLimit,

  /// format conversion failed
  convertFail,

  /// insufficient local space
  freeSpaceLimit,

  /// file upload function is not supported
  uploadNotSupported,

  /// uploading the same file
  uploadDuplicated,

  /// empty domain name
  emptyDomain,

  /// already initialized
  duplicateInit,

  /// the corresponding transc
  serverFileNotExist,

  /// Initializing the log directory specified during initialization failed
  docLogFolderNotAccess,

  /// Initializing the cache directory specified during initialization failed
  docCacheFolderNotAccess,

  /// Initializing the data directory specified during initialization failed
  docDataFolderNotAccess,

  /// Preloading the file failed due to network issues
  cacheFailed,

  /// Format conversion is cancelled
  convertCancel,

  /// The file content is empty, possible reasons include: PDF file without
  /// content, PPT file without slides, Excel file without content, or Word file without content
  fileContentEmpty,

  /// There are elements in the source file that cannot be transcoded
  convertElementNotSupported,

  /// The file suffix does not comply with the ZEGO defined file specification
  convertFileTypeInvalid,

  /// Authentication parameter error
  authParamInvalid,

  /// Path permission insufficient, possible reasons include: the log
  /// directory, cache directory, or data directory specified during initialization is unavailable
  filePathNotAccess,

  /// Initialization failed
  initFailed,

  /// The file is in read-only mode, possible reasons include: dynamic PPT
  /// file is set to read-only mode, or the dynamic PPT file contains fonts not supported by the transcoding server
  fileReadOnly,

  /// Unable to get the current view width and height
  sizeInvalid,

  /// The cursor offset value set exceeds  the cursor size
  graphicCursorOffsetLimit,

  /// Whiteboard token has expired
  whiteboardTokenInvalid,

  /// File token has expired
  docsTokenInvalid,

  /// Incorrect file app sign
  docsSignInvalid,

  /// Preloading the file is not supported
  /// Please contact ZEGO technical support
  /// Possible reasons include: the current AppID has not activated this service, or the file does not support preloading
  cacheNotSupported,

  /// The ZIP file is invalid, possible reasons include: not a valid ZIP file or file corruption
  zipFileInvalid,

  /// The H5 file is invalid and does not conform to the ZEGO defined H5 file  specifications
  /// Possible reasons include: the file does not contain index.html
  h5FileInvalid,
}
