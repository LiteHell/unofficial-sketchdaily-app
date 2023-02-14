import 'package:intl/intl.dart';

class Messages {
  // Basic words
  static String get all => Intl.message('All',
      name: 'all', args: [], desc: 'All, usually used in reference options');
  static String get ok => Intl.message('OK', name: 'ok', args: [], desc: 'OK');
  static String get yes =>
      Intl.message('Yes', name: 'yes', args: [], desc: 'OK');
  static String get no => Intl.message('No', name: 'no', args: [], desc: 'OK');
  static String get other =>
      Intl.message('Other', name: 'other', args: [], desc: 'Other');
  static String get website => Intl.message('Website',
      name: 'website',
      args: [],
      desc:
          'Website, such as SketchDaily website or application github repository');
  static String get start =>
      Intl.message('Start', name: 'start', args: [], desc: 'Start player');
  static String get unknown => Intl.message('Unknown',
      name: 'unknown',
      args: [],
      desc: 'Unknown, usually used for handling null values');

  // Gender
  static String get gender => Intl.message('Gender',
      name: 'gender',
      args: [],
      desc: 'Gender of human, usually used in reference options');
  static String get male => Intl.message('Male',
      name: 'male', args: [], desc: 'Male, usually used in reference options');
  static String get female => Intl.message('Female',
      name: 'female',
      args: [],
      desc: 'Female, usually used in reference options');

  // View angle
  static String get viewAngle => Intl.message('View angle',
      name: 'viewAngle', args: [], desc: 'View angle of a picture');
  static String get aboveOrBelow => Intl.message('Above or below',
      name: 'aboveOrBelow', args: [], desc: 'One of view angle option');
  static String get back => Intl.message('Back',
      name: 'back', args: [], desc: 'One of view angle option');
  static String get front => Intl.message('Front',
      name: 'front', args: [], desc: 'One of view angle option');
  static String get side => Intl.message('Side',
      name: 'side', args: [], desc: 'One of view angle option');

  // Reference image category
  static String get animal =>
      Intl.message('Animal', name: 'animal', desc: 'Animal image');
  static String get fullBody =>
      Intl.message('Full body', name: 'fullBody', desc: 'Full body image');
  static String get bodyPart =>
      Intl.message('Body part', name: 'bodyPart', desc: 'Body part image');
  static String get structure => Intl.message('Structure',
      name: 'structure', desc: 'Structure image. For example, buildings.');
  static String get vegetation => Intl.message('Vegetation',
      name: 'vegetation',
      desc: 'Vegetation image, consisted of fruits and plants');

  // Main page
  static String get sketchDailyReference => Intl.message(
      'SketchDaily reference',
      name: 'sketchDailyReference',
      args: [],
      desc:
          'Means website "SketchDaily reference" or this application, Usually used as app title, or in About... page');
  static String get news => Intl.message('News',
      name: 'news',
      args: [],
      desc: 'Means news from SketchDaily reference website');
  static String get announcement => Intl.message('Announcement',
      name: 'announcement',
      args: [],
      desc: 'Means announcments from SketchDaily');
  static String get startDrawing => Intl.message('Start Drawing!',
      name: 'startDrawing',
      args: [],
      desc:
          'Button text of "Start Drawing!" button, visible in first app screen');
  static String wroteAt(String date) => Intl.message('Wrote at $date',
      name: 'wroteAt',
      args: [date],
      desc: 'A bit smaller text on bottom of news article, with news date');
  static String get doNotShowThisAgain => Intl.message('Do not show this again',
      name: 'doNotShowThisAgain',
      args: [],
      desc: 'Checkbox label in announcement dialog');

  // Picture Player
  // * Timer strings
  static String get requestingNextImage => Intl.message(
      'Requesting Next Image...',
      name: 'requestingNextImage',
      args: [],
      desc:
          'Displayed at elapsed(or remaining) time position when requesting next image information');
  static String get downloadingImage => Intl.message('Downloading image...',
      name: 'downloadingImage',
      args: [],
      desc:
          'Displayed at elapsed(or remaining) time position when downloading next image');
  static String elapsedTimeInInfinityTimer(String time) =>
      Intl.message('$time (Infinite)',
          name: 'elapsedTimeInInfinityTimer',
          args: [time],
          desc: 'Elapsed time, but with infinity timer');
  static String get infinityTimer => Intl.message('Infinite',
      name: 'infinityTimer',
      args: [],
      desc:
          'Infinity timer, displayed at elapsed(or remaining) time position, without elapsed time, only when "Display elapsed time even with Infinity timer" option is not enabled');

  // * Button tooltips
  static String get goFirst => Intl.message('First image',
      name: 'goFirst',
      args: [],
      desc: 'Tooltip of icon button to display first image');
  static String get goPrev => Intl.message('Previous image',
      name: 'goPrev',
      args: [],
      desc: 'Tooltip of icon button to display previous image');
  static String get goNext => Intl.message('Next image',
      name: 'goNext',
      args: [],
      desc:
          'Tooltip of icon button to display next image, fetching new image when needed');
  static String get goLast => Intl.message('Last image',
      name: 'goLast',
      args: [],
      desc: 'Tooltip of icon button to display last image');
  static String get resume => Intl.message('Resume',
      name: 'resume',
      args: [],
      desc: 'Tooltip of icon button to resume player');
  static String get pause => Intl.message('Pause',
      name: 'pause', args: [], desc: 'Tooltip of icon button to resume Player');
  static String get horizontalFlip => Intl.message(
      'Horizontally flip this image',
      name: 'horizontalFlip',
      args: [],
      desc:
          'Tooltip of icon button to horizontally flip the image on player, like mirror.');

  // * Action menus
  static String get openReportImageButton => Intl.message('Report this image',
      name: 'openReportImageButton',
      args: [],
      desc: 'Text of menu item to report a image displayed in the player');
  static String get imageInformation => Intl.message('Image information',
      name: 'imageInformation',
      args: [],
      desc:
          'Text of menu item to display information of current image of the player');
  static String get shareImage => Intl.message('Share this image',
      name: 'shareImage',
      args: [],
      desc: 'Text of menu item to share current image of the player');

  // * Error message
  static String get noMoreImages => Intl.message('No more images',
      name: 'noMoreImages',
      args: [],
      desc:
          'Error message when no more images are available with options given');

  // Menu button texts
  static String get preferences => Intl.message('Preferences',
      name: 'preferences', args: [], desc: 'Application preferences');
  static String get about => Intl.message('About...',
      name: 'about',
      args: [],
      desc:
          'Text of menu item to open app information page, this page includes author, github url, license, etc.');

  // Report Image page
  // * Report type
  static String get inappopriate => Intl.message('Inappopriate',
      name: 'inappopriate',
      args: [],
      desc:
          'One of report types in Report image page, meaning an inappopriate image');
  static String get copyrightViolation => Intl.message('Copyright violation',
      name: 'copyrightViolation',
      args: [],
      desc:
          'One of report types in Report image page, meaning an image violating copyright');
  static String get lowQaulity => Intl.message('Low qaulity',
      name: 'lowQaulity',
      args: [],
      desc:
          'One of report types in Report image page, meaning a low quality image');
  static String get wrongClassifications => Intl.message(
      'Wrong classifications',
      name: 'wrongClassifications',
      args: [],
      desc:
          'One of report types in Report image page, meaning an image with wrong classifications');
  static String get reportComment => Intl.message('Comment',
      name: 'reportComment', args: [], desc: 'Comment when report an image');
  static String get reportType => Intl.message('Report type',
      name: 'reportType',
      args: [],
      desc: 'Required category when reporting an image');
  static String get reportImageTitle => Intl.message('Report image',
      name: 'reportImageTitle', args: [], desc: 'Title of report image page');
  static String get reportImageButton => Intl.message('Report problem',
      name: 'reportImageButton',
      args: [],
      desc: 'Text of report button in report image page');

  // About page
  static String get aboutTitle => Intl.message('About',
      name: 'aboutTitle', args: [], desc: 'Title of about page');
  static String get author => Intl.message('Author',
      name: 'author',
      args: [],
      desc: 'Author of Sketchdaily reference website or this application');
  static String get aboutSketchDailyReference => Intl.message(
      'About Sketchdaily reference',
      name: 'aboutSketchDailyReference',
      args: [],
      desc: 'Header row text in about page, on top of website author/url info');
  static String get githubRepository => Intl.message('GitHub Repository',
      name: 'githubRepository',
      args: [],
      desc: 'GitHub repository of this application');
  static String get appLicense => Intl.message('License',
      name: 'appLicense', args: [], desc: 'License of this application');
  static String get aboutApplication => Intl.message('About Application',
      name: 'aboutApplication',
      args: [],
      desc:
          'Header row text in about page, on top of applicatio author/github-repo/license info');
  static String get gplNotice => Intl.message(
      'GNU General Public License version 3, or (at your option) any later version',
      name: 'gplNotice',
      args: [],
      desc: 'GPLv3+ License notice of this application');

  // Drawing options page
  static String get referenceOptionsTitle => Intl.message('Reference options',
      name: 'referenceOptionsTitle',
      args: [],
      desc: 'Reference options page title');
  static String get timeInSeconds => Intl.message('Time (in seconds)',
      name: 'timeInSeconds',
      args: [],
      desc: 'Label of time text field, in seconds');
  static String get infiniteTimeCheckbox => Intl.message('Infinite time',
      name: 'infiniteTimeCheckbox',
      args: [],
      desc: 'Label of infinity-timer checkbox');
  static String get loadingImageCount => Intl.message('Loading image count...',
      name: 'loadingImageCount',
      args: [],
      desc: 'Text displayed instead of image count when loading');
  static String nImagesAvailable(String count) =>
      Intl.message('$count images available',
          name: 'nImagesAvailable',
          args: [count],
          desc: 'Available image count with options given');

  // Full body options
  static String get clothing => Intl.message('Clothing',
      name: 'clothing', args: [], desc: 'Clothed of nude?');
  static String get nsfw =>
      Intl.message('NSFW', name: 'nsfw', args: [], desc: 'NSFW or not?');
  static String get clothingAndNSFW => Intl.message('Clothing and NSFW',
      name: 'clothingAndNSFW',
      args: [],
      desc: 'Header of clothing(clothed or nude?) and nsfw settings');
  static String get clothed => Intl.message('Clothed',
      name: 'clothed', args: [], desc: 'Clothed, another selection is Nude.');
  static String get nude => Intl.message('Nude',
      name: 'nude', args: [], desc: 'Nlothed, another selection is Clothed.');
  static String get includeNSFWImages => Intl.message('Include NSFW images',
      name: 'includeNSFWImages',
      args: [],
      desc: 'Label of checkbox to include NSFW images');

  // Picture information
  static String get pictureInformation => Intl.message('Picture information',
      name: 'pictureInformation', args: [], desc: 'Title of picture info page');
  static String get personName => Intl.message('Name',
      name: 'personName',
      args: [],
      desc: 'Name of a person, which is model or photographer');
  static String get personWebpage => Intl.message('Webpage',
      name: 'personWebpage',
      args: [],
      desc: 'Webpage of a person, which is model or photographer');
  static String get imageClassification => Intl.message('Image classification',
      name: 'imageClassification',
      args: [],
      desc: 'Image classification, displayed in picture info plage');
  static String get imageIdAndUploadInformation => Intl.message(
      'Image id and upload information',
      name: 'imageIdAndUploadInformation',
      args: [],
      desc:
          'Image id and other infos such as uploader, upload date, terms of use, source url');
  static String get imageId =>
      Intl.message('Image id', name: 'imageId', args: [], desc: 'Image id');
  static String get uploadedBy => Intl.message('Uploaded by',
      name: 'uploadedBy',
      args: [],
      desc: 'Used for displaying uploader nickname');
  static String get uploadedAt => Intl.message('Uploaded at',
      name: 'uploadedAt', args: [], desc: 'Used for displaying upload date');
  static String get termsOfUse => Intl.message('Terms of Use',
      name: 'termsOfUse', args: [], desc: 'Image terms of use');
  static String get imageSourceUrl => Intl.message('Source url',
      name: 'imageSourceUrl', args: [], desc: 'Image source url');
  static String get photographer => Intl.message('Photographer',
      name: 'photographer', args: [], desc: 'Image photographer');
  static String get model => Intl.message('Model',
      name: 'model',
      args: [],
      desc: 'Image model, usually visible in Full body or Body part pictures');
  static String get empty => Intl.message('(Empty)',
      name: 'empty',
      args: [],
      desc: 'Used when terms of use or source uri is empty');

  // App preference
  static String get skipNewsPageWhenNoMoreLatestNews =>
      Intl.message("Skip news page when there's no new news",
          name: 'skipNewsPageWhenNoMoreLatestNews',
          args: [],
          desc: 'Boolean-type app preference');

  // * Headers
  static String get newsAndAnnouncementsPreferences =>
      Intl.message('News and announcements',
          name: 'newsAndAnnouncementsPreferences',
          args: [],
          desc: 'Preferences about news page and announcements');
  static String get referenceOptionsPreferences =>
      Intl.message('Reference options',
          name: 'referenceOptionsPreferences',
          args: [],
          desc: 'Preferences on reference options');
  static String get playerOptions => Intl.message('Player options',
      name: 'playerOptions', args: [], desc: 'Preferences on image player');

  // * Items
  static String get clearDrawingOptions => Intl.message("Clear drawing options",
      name: 'clearDrawingOptions', args: [], desc: 'void-type app preference');
  static String get clearDrawingOptionsDescription => Intl.message(
      'Clear drawing options saved, such as Species(Animal) or gender(Full body / Body part)',
      name: 'clearDrawingOptionsDescription',
      args: [],
      desc: 'void-type app preference');

  static String get clearTimeValues => Intl.message('Clear time values',
      name: 'clearTimeValues', args: [], desc: 'void-type app preference');
  static String get clearTimeValuesDescription => Intl.message(
      "Clear time values and whether It's infinity or not in drawing options",
      name: 'clearTimeValuesDescription',
      args: [],
      desc: 'void-type app preference');

  static String get displayElapsedTimeWithInfinityTimer =>
      Intl.message("Display elapsed time when infinite time is enabled",
          name: 'displayElapsedTimeWithInfinityTimer',
          args: [],
          desc: 'boolean-type app preference');
  static String get displayElapsedTimeWithInfinityTimerDescription => Intl.message(
      'Display elapsed time, in format of "??:?? (Infinite)", when infinite time is enabled',
      name: 'displayElapsedTimeWithInfinityTimerDescription',
      args: [],
      desc: 'boolean-type app preference');

  static String get displayElapsedTime => Intl.message('Display elapsed time',
      name: 'displayElapsedTime',
      args: [],
      desc: 'boolean-type app preference');
  static String get displayElapsedTimeDescription =>
      Intl.message('Display elapsed time instead of remaining time',
          name: 'displayElapsedTimeDescription',
          args: [],
          desc: 'boolean-type app preference');

  static String get clearImageCache => Intl.message("Clear image cache",
      name: 'clearImageCache', args: [], desc: 'void-type app preference');
  static String get clearImageCacheDescription =>
      Intl.message('Maybe useful when device storage is near full',
          name: 'clearImageCacheDescription',
          args: [],
          desc: 'void-type app preference');

  // Enums
  // * AnimalSpecies
  static String get animalSpecies => Intl.message('Species',
      name: 'animalSpecies',
      args: [],
      desc: 'Animal species, such as birds or fishes');
  static String get bird => Intl.message('Bird',
      name: 'bird', args: [], desc: 'One of animal species');
  static String get fish => Intl.message('Fish',
      name: 'fish', args: [], desc: 'One of animal species');
  static String get reptileOrAmphibian => Intl.message('Reptile Or Amphibian',
      name: 'reptileOrAmphibian', args: [], desc: 'One of animal species');
  static String get bug =>
      Intl.message('Bug', name: 'bug', args: [], desc: 'One of animal species');
  static String get mammal => Intl.message('Mammal',
      name: 'mammal', args: [], desc: 'One of animal species');

  // * AnimalCategory
  static String get animalCategory => Intl.message('Category',
      name: 'animalCategory',
      args: [],
      desc: 'Animal category, such as living or dead');
  static String get livingAnimal => Intl.message('Living',
      name: 'livingAnimal', args: [], desc: 'One of animal category');
  static String get animalSkeletonOrBones => Intl.message('Skeleton or bones',
      name: 'animalSkeletonOrBones', args: [], desc: 'One of animal category');

  // * BodyPartType
  static String get bodyPartType => Intl.message('Body part',
      name: 'bodyPartType',
      args: [],
      desc: 'Body part types, such as foot, head, hand.');
  static String get foot => Intl.message('Foot',
      name: 'foot', args: [], desc: 'One of body part type');
  static String get head => Intl.message('Head',
      name: 'head', args: [], desc: 'One of body part type');
  static String get hand => Intl.message('Hand',
      name: 'hand', args: [], desc: 'One of body part type');

  // * PoseType
  static String get poseType => Intl.message('Pose type',
      name: 'poseType',
      args: [],
      desc: 'Pose type, such as action or stationary');
  static String get actionPose => Intl.message('Action',
      name: 'actionPose', args: [], desc: 'One of pose types');
  static String get stationaryPose => Intl.message('Stationary',
      name: 'stationaryPose', args: [], desc: 'One of pose types');

  // * StructureType
  static String get structureType => Intl.message('Type',
      name: 'structureType',
      args: [],
      desc: 'Structure type, such as building or house');
  static String get building => Intl.message('Building',
      name: 'building', args: [], desc: 'One of structure types');
  static String get house => Intl.message('House',
      name: 'house', args: [], desc: 'One of structure types');

  // * VegetationType
  static String get vegetationType => Intl.message('Vegetation type',
      name: 'vegetationType',
      args: [],
      desc: 'Vegetation types, such as flowers and plants');
  static String get flower => Intl.message('Flower',
      name: 'flower', args: [], desc: 'One of vegetation types');
  static String get plant => Intl.message('Plant',
      name: 'plant', args: [], desc: 'One of vegetation types');

  // * VegetationType
  static String get vegetationPhotoType => Intl.message('Photo type',
      name: 'vegetationPhotoType',
      args: [],
      desc: 'Vegetation photo types, such as closeup and full');
  static String get closeup => Intl.message('Closeup',
      name: 'closeup', args: [], desc: 'One of vegetation photo types');
  static String get fullVegetationPhotoType => Intl.message('Full',
      name: 'fullVegetationPhotoType',
      args: [],
      desc: 'One of vegetation photo types');
}
