// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `SAMMLY`
  String get appname {
    return Intl.message('SAMMLY', name: 'appname', desc: '', args: []);
  }

  /// `AI INTERIOR DESIGN`
  String get appdesc {
    return Intl.message(
      'AI INTERIOR DESIGN',
      name: 'appdesc',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Explore`
  String get explore {
    return Intl.message('Explore', name: 'explore', desc: '', args: []);
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Favorite`
  String get favorite {
    return Intl.message('Favorite', name: 'favorite', desc: '', args: []);
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Bathroom`
  String get bathroom {
    return Intl.message('Bathroom', name: 'bathroom', desc: '', args: []);
  }

  /// `Bedroom`
  String get bedroom {
    return Intl.message('Bedroom', name: 'bedroom', desc: '', args: []);
  }

  /// `Dining Room`
  String get diningRoom {
    return Intl.message('Dining Room', name: 'diningRoom', desc: '', args: []);
  }

  /// `Kitchen`
  String get kitchen {
    return Intl.message('Kitchen', name: 'kitchen', desc: '', args: []);
  }

  /// `Living Room`
  String get livingRoom {
    return Intl.message('Living Room', name: 'livingRoom', desc: '', args: []);
  }

  /// `No Favorites`
  String get noFavorites {
    return Intl.message(
      'No Favorites',
      name: 'noFavorites',
      desc: '',
      args: [],
    );
  }

  /// `Your favorite list is empty`
  String get noFavoritesDesc {
    return Intl.message(
      'Your favorite list is empty',
      name: 'noFavoritesDesc',
      desc: '',
      args: [],
    );
  }

  /// `No History`
  String get noHistory {
    return Intl.message('No History', name: 'noHistory', desc: '', args: []);
  }

  /// `Your history list is empty`
  String get noHistoryDesc {
    return Intl.message(
      'Your history list is empty',
      name: 'noHistoryDesc',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Design your space with AI`
  String get onboarding1Title {
    return Intl.message(
      'Design your space with AI',
      name: 'onboarding1Title',
      desc: '',
      args: [],
    );
  }

  /// `Generate new room designs from text prompts or edit existing rooms using uploaded images.`
  String get onboarding1Subtitle {
    return Intl.message(
      'Generate new room designs from text prompts or edit existing rooms using uploaded images.',
      name: 'onboarding1Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Find items in your design`
  String get onboarding2Title {
    return Intl.message(
      'Find items in your design',
      name: 'onboarding2Title',
      desc: '',
      args: [],
    );
  }

  /// `Select any item in the generated image and discover where it's available.`
  String get onboarding2Subtitle {
    return Intl.message(
      'Select any item in the generated image and discover where it\'s available.',
      name: 'onboarding2Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Share & earn tokens`
  String get onboarding3Title {
    return Intl.message(
      'Share & earn tokens',
      name: 'onboarding3Title',
      desc: '',
      args: [],
    );
  }

  /// `Explore community designs, share your creations, and earn free tokens as rewards.`
  String get onboarding3Subtitle {
    return Intl.message(
      'Explore community designs, share your creations, and earn free tokens as rewards.',
      name: 'onboarding3Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Welcome,`
  String get greetingPrefix {
    return Intl.message('Welcome,', name: 'greetingPrefix', desc: '', args: []);
  }

  /// `Let's design your dream space.`
  String get subtitle {
    return Intl.message(
      'Let\'s design your dream space.',
      name: 'subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Search for......`
  String get searchHint {
    return Intl.message(
      'Search for......',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `AI POWERED`
  String get aiTag {
    return Intl.message('AI POWERED', name: 'aiTag', desc: '', args: []);
  }

  /// `Visualize your room with AI`
  String get aiBannerTitle {
    return Intl.message(
      'Visualize your room with AI',
      name: 'aiBannerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Type what you imagine and AI will generate your room.`
  String get aiBannerSubtitle {
    return Intl.message(
      'Type what you imagine and AI will generate your room.',
      name: 'aiBannerSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Start Generate`
  String get startGenerateBtn {
    return Intl.message(
      'Start Generate',
      name: 'startGenerateBtn',
      desc: '',
      args: [],
    );
  }

  /// `Explore Styles`
  String get exploreStyles {
    return Intl.message(
      'Explore Styles',
      name: 'exploreStyles',
      desc: '',
      args: [],
    );
  }

  /// `view all`
  String get viewAll {
    return Intl.message('view all', name: 'viewAll', desc: '', args: []);
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message('My Profile', name: 'myProfile', desc: '', args: []);
  }

  /// `Shared Images`
  String get sharedImages {
    return Intl.message(
      'Shared Images',
      name: 'sharedImages',
      desc: '',
      args: [],
    );
  }

  /// `View My Posts`
  String get viewMyPosts {
    return Intl.message(
      'View My Posts',
      name: 'viewMyPosts',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message('Favorites', name: 'favorites', desc: '', args: []);
  }

  /// `Following`
  String get following {
    return Intl.message('Following', name: 'following', desc: '', args: []);
  }

  /// `Follow`
  String get follow {
    return Intl.message('Follow', name: 'follow', desc: '', args: []);
  }

  /// `Unfollow`
  String get unfollow {
    return Intl.message('Unfollow', name: 'unfollow', desc: '', args: []);
  }

  /// `Free Generations`
  String get freeGenerations {
    return Intl.message(
      'Free Generations',
      name: 'freeGenerations',
      desc: '',
      args: [],
    );
  }

  /// `Manage Subscription`
  String get manageSubscription {
    return Intl.message(
      'Manage Subscription',
      name: 'manageSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get support {
    return Intl.message('Support', name: 'support', desc: '', args: []);
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get termsConditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'termsConditions',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message('Share', name: 'share', desc: '', args: []);
  }

  /// `Log Out`
  String get logOut {
    return Intl.message('Log Out', name: 'logOut', desc: '', args: []);
  }

  /// `Earn Tokens`
  String get rewardTokens {
    return Intl.message(
      'Earn Tokens',
      name: 'rewardTokens',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade PRO`
  String get upgradePro {
    return Intl.message('Upgrade PRO', name: 'upgradePro', desc: '', args: []);
  }

  /// `Security`
  String get security {
    return Intl.message('Security', name: 'security', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `No followings`
  String get noFollowings {
    return Intl.message(
      'No followings',
      name: 'noFollowings',
      desc: '',
      args: [],
    );
  }

  /// `Browse Designs and Follow Others`
  String get noFollowingsDesc {
    return Intl.message(
      'Browse Designs and Follow Others',
      name: 'noFollowingsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Edit profile`
  String get editProfile {
    return Intl.message(
      'Edit profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Change image`
  String get changeImage {
    return Intl.message(
      'Change image',
      name: 'changeImage',
      desc: '',
      args: [],
    );
  }

  /// `Upload Image`
  String get uploadImage {
    return Intl.message(
      'Upload Image',
      name: 'uploadImage',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get fullName {
    return Intl.message('Full name', name: 'fullName', desc: '', args: []);
  }

  /// `User name`
  String get userName {
    return Intl.message('User name', name: 'userName', desc: '', args: []);
  }

  /// `Date of birth`
  String get dateOfBirth {
    return Intl.message(
      'Date of birth',
      name: 'dateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phoneNumber {
    return Intl.message(
      'Phone number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message('Country', name: 'country', desc: '', args: []);
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `select your gender`
  String get selectYourGender {
    return Intl.message(
      'select your gender',
      name: 'selectYourGender',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Like your shared design`
  String get likeYourSharedDesign {
    return Intl.message(
      'Like your shared design',
      name: 'likeYourSharedDesign',
      desc: '',
      args: [],
    );
  }

  /// `No Notifications`
  String get noNotifications {
    return Intl.message(
      'No Notifications',
      name: 'noNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Notification Inbox Empty`
  String get noNotificationsDesc {
    return Intl.message(
      'Notification Inbox Empty',
      name: 'noNotificationsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Invite Friends`
  String get inviteFriends {
    return Intl.message(
      'Invite Friends',
      name: 'inviteFriends',
      desc: '',
      args: [],
    );
  }

  /// `Tell your friend its free and easy to generate your own design`
  String get inviteFriendsDesc {
    return Intl.message(
      'Tell your friend its free and easy to generate your own design',
      name: 'inviteFriendsDesc',
      desc: '',
      args: [],
    );
  }

  /// `COPY LINK`
  String get copyLink {
    return Intl.message('COPY LINK', name: 'copyLink', desc: '', args: []);
  }

  /// `Link Copied!`
  String get linkCopied {
    return Intl.message('Link Copied!', name: 'linkCopied', desc: '', args: []);
  }

  /// `Or share on....`
  String get orShareOn {
    return Intl.message(
      'Or share on....',
      name: 'orShareOn',
      desc: '',
      args: [],
    );
  }

  /// `https://drive.google.com/drive/folders/1J-vtrMlETkIt9Yk0VGE2CcPrc8ttdvoG?usp=sharing`
  String get dummyInviteLink {
    return Intl.message(
      'https://drive.google.com/drive/folders/1J-vtrMlETkIt9Yk0VGE2CcPrc8ttdvoG?usp=sharing',
      name: 'dummyInviteLink',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get logoutConfirmMsg {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'logoutConfirmMsg',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `AI Room Generation`
  String get aiRoomGeneration {
    return Intl.message(
      'AI Room Generation',
      name: 'aiRoomGeneration',
      desc: '',
      args: [],
    );
  }

  /// `Describe your dream room with a simple prompt and generate realistic interior designs instantly.`
  String get aiRoomGenerationDesc {
    return Intl.message(
      'Describe your dream room with a simple prompt and generate realistic interior designs instantly.',
      name: 'aiRoomGenerationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Full Home Design`
  String get fullHomeDesign {
    return Intl.message(
      'Full Home Design',
      name: 'fullHomeDesign',
      desc: '',
      args: [],
    );
  }

  /// `Upload one room photo and generate matching designs for the rest of your home.`
  String get fullHomeDesignDesc {
    return Intl.message(
      'Upload one room photo and generate matching designs for the rest of your home.',
      name: 'fullHomeDesignDesc',
      desc: '',
      args: [],
    );
  }

  /// `Full Home`
  String get fullHomeTag {
    return Intl.message('Full Home', name: 'fullHomeTag', desc: '', args: []);
  }

  /// `Room Redesign`
  String get roomRedesign {
    return Intl.message(
      'Room Redesign',
      name: 'roomRedesign',
      desc: '',
      args: [],
    );
  }

  /// `Transform your existing room into a completely new style while keeping the same layout.`
  String get roomRedesignDesc {
    return Intl.message(
      'Transform your existing room into a completely new style while keeping the same layout.',
      name: 'roomRedesignDesc',
      desc: '',
      args: [],
    );
  }

  /// `Restyle Room`
  String get restyleRoomTag {
    return Intl.message(
      'Restyle Room',
      name: 'restyleRoomTag',
      desc: '',
      args: [],
    );
  }

  /// `Room Restyle`
  String get roomRestyle {
    return Intl.message(
      'Room Restyle',
      name: 'roomRestyle',
      desc: '',
      args: [],
    );
  }

  /// `Replace`
  String get replace {
    return Intl.message('Replace', name: 'replace', desc: '', args: []);
  }

  /// `Replace Object`
  String get replaceObject {
    return Intl.message(
      'Replace Object',
      name: 'replaceObject',
      desc: '',
      args: [],
    );
  }

  /// `Remove Object`
  String get removeObject {
    return Intl.message(
      'Remove Object',
      name: 'removeObject',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message('Remove', name: 'remove', desc: '', args: []);
  }

  /// `Mask`
  String get mask {
    return Intl.message('Mask', name: 'mask', desc: '', args: []);
  }

  /// `Upload a photo, draw a mask on the area you want to remove`
  String get removeDesc {
    return Intl.message(
      'Upload a photo, draw a mask on the area you want to remove',
      name: 'removeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Your room is coming soon...`
  String get yourRoomIsComingSoon {
    return Intl.message(
      'Your room is coming soon...',
      name: 'yourRoomIsComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Adding details and finishing touches.`
  String get addingDetails {
    return Intl.message(
      'Adding details and finishing touches.',
      name: 'addingDetails',
      desc: '',
      args: [],
    );
  }

  /// `keep the app open and don't lock your device as the\nprocess may take approximately 10 seconds`
  String get loadingDisclaimer {
    return Intl.message(
      'keep the app open and don\'t lock your device as the\nprocess may take approximately 10 seconds',
      name: 'loadingDisclaimer',
      desc: '',
      args: [],
    );
  }

  /// `Mask Inpainting`
  String get maskInpainting {
    return Intl.message(
      'Mask Inpainting',
      name: 'maskInpainting',
      desc: '',
      args: [],
    );
  }

  /// `Upload a photo, draw a mask on the area you want to change, and describe your vision.`
  String get maskInpaintingDesc {
    return Intl.message(
      'Upload a photo, draw a mask on the area you want to change, and describe your vision.',
      name: 'maskInpaintingDesc',
      desc: '',
      args: [],
    );
  }

  /// `Inpainting`
  String get maskInpaintingTag {
    return Intl.message(
      'Inpainting',
      name: 'maskInpaintingTag',
      desc: '',
      args: [],
    );
  }

  /// `Describe Your Changes`
  String get describeYourChanges {
    return Intl.message(
      'Describe Your Changes',
      name: 'describeYourChanges',
      desc: '',
      args: [],
    );
  }

  /// `Select Room`
  String get selectRoom {
    return Intl.message('Select Room', name: 'selectRoom', desc: '', args: []);
  }

  /// `Select Style`
  String get selectStyle {
    return Intl.message(
      'Select Style',
      name: 'selectStyle',
      desc: '',
      args: [],
    );
  }

  /// `Visualize your Space`
  String get visualizeYourSpace {
    return Intl.message(
      'Visualize your Space',
      name: 'visualizeYourSpace',
      desc: '',
      args: [],
    );
  }

  /// `Describe your dream room.......`
  String get describeDreamRoomHint {
    return Intl.message(
      'Describe your dream room.......',
      name: 'describeDreamRoomHint',
      desc: '',
      args: [],
    );
  }

  /// `Describe the changes you want.......`
  String get describeChangesHint {
    return Intl.message(
      'Describe the changes you want.......',
      name: 'describeChangesHint',
      desc: '',
      args: [],
    );
  }

  /// `Add Image(Optional)`
  String get addImageOptional {
    return Intl.message(
      'Add Image(Optional)',
      name: 'addImageOptional',
      desc: '',
      args: [],
    );
  }

  /// `Upload Room Image`
  String get uploadRoomImage {
    return Intl.message(
      'Upload Room Image',
      name: 'uploadRoomImage',
      desc: '',
      args: [],
    );
  }

  /// `Generate Design`
  String get generateDesign {
    return Intl.message(
      'Generate Design',
      name: 'generateDesign',
      desc: '',
      args: [],
    );
  }

  /// `Traditional`
  String get traditional {
    return Intl.message('Traditional', name: 'traditional', desc: '', args: []);
  }

  /// `Coastal`
  String get coastal {
    return Intl.message('Coastal', name: 'coastal', desc: '', args: []);
  }

  /// `Rustic`
  String get rustic {
    return Intl.message('Rustic', name: 'rustic', desc: '', args: []);
  }

  /// `Mid-century modern`
  String get midCenturyModern {
    return Intl.message(
      'Mid-century modern',
      name: 'midCenturyModern',
      desc: '',
      args: [],
    );
  }

  /// `Bohemian`
  String get boho {
    return Intl.message('Bohemian', name: 'boho', desc: '', args: []);
  }

  /// `Type`
  String get type {
    return Intl.message('Type', name: 'type', desc: '', args: []);
  }

  /// `Style`
  String get style {
    return Intl.message('Style', name: 'style', desc: '', args: []);
  }

  /// `Describe`
  String get describe {
    return Intl.message('Describe', name: 'describe', desc: '', args: []);
  }

  /// `Select`
  String get select {
    return Intl.message('Select', name: 'select', desc: '', args: []);
  }

  /// `Upload Room`
  String get uploadRoom {
    return Intl.message('Upload Room', name: 'uploadRoom', desc: '', args: []);
  }

  /// `Upload reference image`
  String get uploadReferenceImage {
    return Intl.message(
      'Upload reference image',
      name: 'uploadReferenceImage',
      desc: '',
      args: [],
    );
  }

  /// `Restyle your Space`
  String get restyleYourSpace {
    return Intl.message(
      'Restyle your Space',
      name: 'restyleYourSpace',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get upload {
    return Intl.message('Upload', name: 'upload', desc: '', args: []);
  }

  /// `Add Reference Image`
  String get addReferenceImageOnly {
    return Intl.message(
      'Add Reference Image',
      name: 'addReferenceImageOnly',
      desc: '',
      args: [],
    );
  }

  /// `Add Reference Image(Optional)`
  String get addReferenceImageOptional {
    return Intl.message(
      'Add Reference Image(Optional)',
      name: 'addReferenceImageOptional',
      desc: '',
      args: [],
    );
  }

  /// `Upload Your image`
  String get uploadYourImage {
    return Intl.message(
      'Upload Your image',
      name: 'uploadYourImage',
      desc: '',
      args: [],
    );
  }

  /// `Add Your image`
  String get addYourImage {
    return Intl.message(
      'Add Your image',
      name: 'addYourImage',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Please select a Room`
  String get pleaseSelectARoom {
    return Intl.message(
      'Please select a Room',
      name: 'pleaseSelectARoom',
      desc: '',
      args: [],
    );
  }

  /// `Please select a Style`
  String get pleaseSelectAStyle {
    return Intl.message(
      'Please select a Style',
      name: 'pleaseSelectAStyle',
      desc: '',
      args: [],
    );
  }

  /// `Please describe your dream room.`
  String get pleaseDescribeYourDreamRoom {
    return Intl.message(
      'Please describe your dream room.',
      name: 'pleaseDescribeYourDreamRoom',
      desc: '',
      args: [],
    );
  }

  /// `Please upload an image first`
  String get pleaseUploadImage {
    return Intl.message(
      'Please upload an image first',
      name: 'pleaseUploadImage',
      desc: '',
      args: [],
    );
  }

  /// `Please select at least one room`
  String get pleaseSelectAtLeastOneRoom {
    return Intl.message(
      'Please select at least one room',
      name: 'pleaseSelectAtLeastOneRoom',
      desc: '',
      args: [],
    );
  }

  /// `Selet rooms to build based on your image`
  String get buildYourRoom {
    return Intl.message(
      'Selet rooms to build based on your image',
      name: 'buildYourRoom',
      desc: '',
      args: [],
    );
  }

  /// `Generated by SAMMLY`
  String get generatedBySammly {
    return Intl.message(
      'Generated by SAMMLY',
      name: 'generatedBySammly',
      desc: '',
      args: [],
    );
  }

  /// `Smart Lens`
  String get smartLens {
    return Intl.message('Smart Lens', name: 'smartLens', desc: '', args: []);
  }

  /// `Your Generated Designs`
  String get yourGeneratedDesign {
    return Intl.message(
      'Your Generated Designs',
      name: 'yourGeneratedDesign',
      desc: '',
      args: [],
    );
  }

  /// `Modern Living Room`
  String get modernLivingRoom {
    return Intl.message(
      'Modern Living Room',
      name: 'modernLivingRoom',
      desc: '',
      args: [],
    );
  }

  /// `Browse design categories`
  String get exploreBrowseCategories {
    return Intl.message(
      'Browse design categories',
      name: 'exploreBrowseCategories',
      desc: '',
      args: [],
    );
  }

  /// `Explore ready-made styles and rooms organized by category.`
  String get exploreBrowseCategoriesDesc {
    return Intl.message(
      'Explore ready-made styles and rooms organized by category.',
      name: 'exploreBrowseCategoriesDesc',
      desc: '',
      args: [],
    );
  }

  /// `Explore shared designs`
  String get exploreSharedDesigns {
    return Intl.message(
      'Explore shared designs',
      name: 'exploreSharedDesigns',
      desc: '',
      args: [],
    );
  }

  /// `Browse rooms created by other users and get inspired.`
  String get exploreSharedDesignsDesc {
    return Intl.message(
      'Browse rooms created by other users and get inspired.',
      name: 'exploreSharedDesignsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Have an issue?`
  String get supportQuestion {
    return Intl.message(
      'Have an issue?',
      name: 'supportQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Reach out to us via email.`
  String get supportReachOut {
    return Intl.message(
      'Reach out to us via email.',
      name: 'supportReachOut',
      desc: '',
      args: [],
    );
  }

  /// `We're eager to assist you.`
  String get supportEagerToAssist {
    return Intl.message(
      'We\'re eager to assist you.',
      name: 'supportEagerToAssist',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get enterYourEmail {
    return Intl.message(
      'Enter your email',
      name: 'enterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get pleaseEnterYourEmail {
    return Intl.message(
      'Please enter your email',
      name: 'pleaseEnterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get pleaseEnterValidEmail {
    return Intl.message(
      'Please enter a valid email address',
      name: 'pleaseEnterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Subject`
  String get subject {
    return Intl.message('Subject', name: 'subject', desc: '', args: []);
  }

  /// `Select Subject`
  String get selectSubject {
    return Intl.message(
      'Select Subject',
      name: 'selectSubject',
      desc: '',
      args: [],
    );
  }

  /// `Please select a subject`
  String get pleaseSelectSubject {
    return Intl.message(
      'Please select a subject',
      name: 'pleaseSelectSubject',
      desc: '',
      args: [],
    );
  }

  /// `Message:`
  String get message {
    return Intl.message('Message:', name: 'message', desc: '', args: []);
  }

  /// `Enter your message`
  String get enterYourMessage {
    return Intl.message(
      'Enter your message',
      name: 'enterYourMessage',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your message`
  String get pleaseEnterYourMessage {
    return Intl.message(
      'Please enter your message',
      name: 'pleaseEnterYourMessage',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message('Submit', name: 'submit', desc: '', args: []);
  }

  /// `Support request sent successfully!`
  String get supportRequestSuccess {
    return Intl.message(
      'Support request sent successfully!',
      name: 'supportRequestSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Account Problem`
  String get subjectAccountProblem {
    return Intl.message(
      'Account Problem',
      name: 'subjectAccountProblem',
      desc: '',
      args: [],
    );
  }

  /// `Bug Report`
  String get subjectBugReport {
    return Intl.message(
      'Bug Report',
      name: 'subjectBugReport',
      desc: '',
      args: [],
    );
  }

  /// `Feature Request`
  String get subjectFeatureRequest {
    return Intl.message(
      'Feature Request',
      name: 'subjectFeatureRequest',
      desc: '',
      args: [],
    );
  }

  /// `Login Issue`
  String get subjectLoginIssue {
    return Intl.message(
      'Login Issue',
      name: 'subjectLoginIssue',
      desc: '',
      args: [],
    );
  }

  /// `Report User`
  String get subjectReportUser {
    return Intl.message(
      'Report User',
      name: 'subjectReportUser',
      desc: '',
      args: [],
    );
  }

  /// `Registration Problem`
  String get subjectRegistrationProblem {
    return Intl.message(
      'Registration Problem',
      name: 'subjectRegistrationProblem',
      desc: '',
      args: [],
    );
  }

  /// `Verification Code`
  String get subjectVerificationCode {
    return Intl.message(
      'Verification Code',
      name: 'subjectVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Password Reset`
  String get subjectPasswordReset {
    return Intl.message(
      'Password Reset',
      name: 'subjectPasswordReset',
      desc: '',
      args: [],
    );
  }

  /// `Technical Support`
  String get subjectTechnicalSupport {
    return Intl.message(
      'Technical Support',
      name: 'subjectTechnicalSupport',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get subjectOther {
    return Intl.message('Other', name: 'subjectOther', desc: '', args: []);
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `SAMMLY Pro`
  String get sammlyPro {
    return Intl.message('SAMMLY Pro', name: 'sammlyPro', desc: '', args: []);
  }

  /// `Pick the perfect plan to bring your\ndream spaces to life`
  String get pickPerfectPlan {
    return Intl.message(
      'Pick the perfect plan to bring your\ndream spaces to life',
      name: 'pickPerfectPlan',
      desc: '',
      args: [],
    );
  }

  /// `Starter`
  String get planStarter {
    return Intl.message('Starter', name: 'planStarter', desc: '', args: []);
  }

  /// `Pro`
  String get planPro {
    return Intl.message('Pro', name: 'planPro', desc: '', args: []);
  }

  /// `Premium`
  String get planPremium {
    return Intl.message('Premium', name: 'planPremium', desc: '', args: []);
  }

  /// `Great for starters`
  String get greatForStarters {
    return Intl.message(
      'Great for starters',
      name: 'greatForStarters',
      desc: '',
      args: [],
    );
  }

  /// `10 premium generations`
  String get generations10 {
    return Intl.message(
      '10 premium generations',
      name: 'generations10',
      desc: '',
      args: [],
    );
  }

  /// `30 premium generations`
  String get generations30 {
    return Intl.message(
      '30 premium generations',
      name: 'generations30',
      desc: '',
      args: [],
    );
  }

  /// `100 premium generations`
  String get generations100 {
    return Intl.message(
      '100 premium generations',
      name: 'generations100',
      desc: '',
      args: [],
    );
  }

  /// `5 premium generations`
  String get generations5 {
    return Intl.message(
      '5 premium generations',
      name: 'generations5',
      desc: '',
      args: [],
    );
  }

  /// `Perfect way to try SAMMLY and\nexplore premium features`
  String get perfectWayToTry {
    return Intl.message(
      'Perfect way to try SAMMLY and\nexplore premium features',
      name: 'perfectWayToTry',
      desc: '',
      args: [],
    );
  }

  /// `EGP 150`
  String get egp150 {
    return Intl.message('EGP 150', name: 'egp150', desc: '', args: []);
  }

  /// `EGP 370`
  String get egp370 {
    return Intl.message('EGP 370', name: 'egp370', desc: '', args: []);
  }

  /// `EGP 955`
  String get egp955 {
    return Intl.message('EGP 955', name: 'egp955', desc: '', args: []);
  }

  /// `/pack`
  String get perPack {
    return Intl.message('/pack', name: 'perPack', desc: '', args: []);
  }

  /// `Free`
  String get free {
    return Intl.message('Free', name: 'free', desc: '', args: []);
  }

  /// `Subscribe`
  String get subscribe {
    return Intl.message('Subscribe', name: 'subscribe', desc: '', args: []);
  }

  /// `Welcome Back`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Login in to your account`
  String get loginToAccount {
    return Intl.message(
      'Login in to your account',
      name: 'loginToAccount',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get enterYourEmailHint {
    return Intl.message(
      'Enter your email',
      name: 'enterYourEmailHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get enterYourPasswordHint {
    return Intl.message(
      'Enter your password',
      name: 'enterYourPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get logIn {
    return Intl.message('Log In', name: 'logIn', desc: '', args: []);
  }

  /// `Or login with`
  String get orLoginWith {
    return Intl.message(
      'Or login with',
      name: 'orLoginWith',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message('Sign up', name: 'signUp', desc: '', args: []);
  }

  /// `Sign UP`
  String get signUpTitle {
    return Intl.message('Sign UP', name: 'signUpTitle', desc: '', args: []);
  }

  /// `Create your new account`
  String get createNewAccount {
    return Intl.message(
      'Create your new account',
      name: 'createNewAccount',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get enterYourName {
    return Intl.message(
      'Enter your name',
      name: 'enterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `I agree to all the `
  String get iAgreeToAll {
    return Intl.message(
      'I agree to all the ',
      name: 'iAgreeToAll',
      desc: '',
      args: [],
    );
  }

  /// `Or Signup with`
  String get orSignupWith {
    return Intl.message(
      'Or Signup with',
      name: 'orSignupWith',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Verification`
  String get verification {
    return Intl.message(
      'Verification',
      name: 'verification',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code sent to`
  String get enterCodeSentTo {
    return Intl.message(
      'Enter the code sent to',
      name: 'enterCodeSentTo',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message('Verify', name: 'verify', desc: '', args: []);
  }

  /// `Didn't receive the code?`
  String get didntReceiveCode {
    return Intl.message(
      'Didn\'t receive the code?',
      name: 'didntReceiveCode',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message('Resend Code', name: 'resendCode', desc: '', args: []);
  }

  /// `Forgot Password`
  String get forgotPasswordTitle {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address and we will send you a verification code to reset your password`
  String get forgotPasswordDesc {
    return Intl.message(
      'Enter your email address and we will send you a verification code to reset your password',
      name: 'forgotPasswordDesc',
      desc: '',
      args: [],
    );
  }

  /// `Send Code`
  String get sendCode {
    return Intl.message('Send Code', name: 'sendCode', desc: '', args: []);
  }

  /// `Create new password`
  String get createNewPassword {
    return Intl.message(
      'Create new password',
      name: 'createNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Your new password must be unique from those previously used.`
  String get createNewPasswordDesc {
    return Intl.message(
      'Your new password must be unique from those previously used.',
      name: 'createNewPasswordDesc',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm new password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password Changed!`
  String get passwordChanged {
    return Intl.message(
      'Password Changed!',
      name: 'passwordChanged',
      desc: '',
      args: [],
    );
  }

  /// `Your password has been changed successfully.`
  String get passwordChangedDesc {
    return Intl.message(
      'Your password has been changed successfully.',
      name: 'passwordChangedDesc',
      desc: '',
      args: [],
    );
  }

  /// `Back to Login`
  String get backToLogin {
    return Intl.message(
      'Back to Login',
      name: 'backToLogin',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get currentPassword {
    return Intl.message(
      'Current Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// ` and `
  String get and {
    return Intl.message(' and ', name: 'and', desc: '', args: []);
  }

  /// `By accessing and using this application, you agree to follow the terms and conditions outlined below\n\nUsers are responsible for the content they create or share within the app.\n\nAny harmful, illegal, or inappropriate use of the application is strictly prohibited.\n\nThe app is intended for personal and non-commercial use only.\n\nWe reserve the right to update or modify these terms at any time without prior notice.\n\nContinued use of the application means that you accept any changes made to these terms.`
  String get termsConditionsText {
    return Intl.message(
      'By accessing and using this application, you agree to follow the terms and conditions outlined below\n\nUsers are responsible for the content they create or share within the app.\n\nAny harmful, illegal, or inappropriate use of the application is strictly prohibited.\n\nThe app is intended for personal and non-commercial use only.\n\nWe reserve the right to update or modify these terms at any time without prior notice.\n\nContinued use of the application means that you accept any changes made to these terms.',
      name: 'termsConditionsText',
      desc: '',
      args: [],
    );
  }

  /// `We respect your privacy and are committed to protecting your personal information.\n\nOur app may collect limited information such as your email address, user inputs (prompts), and images generated within the app.\n\nThis information is used only to improve the user experience and provide better services.\n\nWe do not sell, trade, or share your personal information with third parties.\n\nAll data is handled securely and used only for the purpose of operating and improving the application.\n\nBy using this app, you agree to the collection and use of information in accordance with this privacy policy.`
  String get privacyPolicyText {
    return Intl.message(
      'We respect your privacy and are committed to protecting your personal information.\n\nOur app may collect limited information such as your email address, user inputs (prompts), and images generated within the app.\n\nThis information is used only to improve the user experience and provide better services.\n\nWe do not sell, trade, or share your personal information with third parties.\n\nAll data is handled securely and used only for the purpose of operating and improving the application.\n\nBy using this app, you agree to the collection and use of information in accordance with this privacy policy.',
      name: 'privacyPolicyText',
      desc: '',
      args: [],
    );
  }

  /// `Please accept the Terms & Conditions`
  String get pleaseAcceptTerms {
    return Intl.message(
      'Please accept the Terms & Conditions',
      name: 'pleaseAcceptTerms',
      desc: '',
      args: [],
    );
  }

  /// `Verification code sent!`
  String get verificationCodeSent {
    return Intl.message(
      'Verification code sent!',
      name: 'verificationCodeSent',
      desc: '',
      args: [],
    );
  }

  /// `Please enter all 4 digits`
  String get pleaseEnterAllDigits {
    return Intl.message(
      'Please enter all 4 digits',
      name: 'pleaseEnterAllDigits',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully!`
  String get passwordChangedSuccess {
    return Intl.message(
      'Password changed successfully!',
      name: 'passwordChangedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Registration successful! Please check your email to verify your account.`
  String get registrationSuccessVerifyEmail {
    return Intl.message(
      'Registration successful! Please check your email to verify your account.',
      name: 'registrationSuccessVerifyEmail',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back, {name}!`
  String welcomeBackSnackbar(Object name) {
    return Intl.message(
      'Welcome back, $name!',
      name: 'welcomeBackSnackbar',
      desc: '',
      args: [name],
    );
  }

  /// `Profile updated successfully!`
  String get profileUpdatedSuccess {
    return Intl.message(
      'Profile updated successfully!',
      name: 'profileUpdatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Wait...`
  String get waitText {
    return Intl.message('Wait...', name: 'waitText', desc: '', args: []);
  }

  /// `Error saving image: {error}`
  String errorSavingImage(Object error) {
    return Intl.message(
      'Error saving image: $error',
      name: 'errorSavingImage',
      desc: '',
      args: [error],
    );
  }

  /// `Failed to extract mask. Please try again.`
  String get failedToExtractMask {
    return Intl.message(
      'Failed to extract mask. Please try again.',
      name: 'failedToExtractMask',
      desc: '',
      args: [],
    );
  }

  /// `Image saved to gallery successfully!`
  String get imageSavedSuccess {
    return Intl.message(
      'Image saved to gallery successfully!',
      name: 'imageSavedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the 6-digit code`
  String get pleaseEnter6DigitCode {
    return Intl.message(
      'Please enter the 6-digit code',
      name: 'pleaseEnter6DigitCode',
      desc: '',
      args: [],
    );
  }

  /// `Verification code resent to your email`
  String get verificationCodeResent {
    return Intl.message(
      'Verification code resent to your email',
      name: 'verificationCodeResent',
      desc: '',
      args: [],
    );
  }

  /// `Please verify your email to continue.`
  String get pleaseVerifyEmail {
    return Intl.message(
      'Please verify your email to continue.',
      name: 'pleaseVerifyEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get pleaseEnterYourName {
    return Intl.message(
      'Please enter your name',
      name: 'pleaseEnterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get pleaseEnterYourPassword {
    return Intl.message(
      'Please enter your password',
      name: 'pleaseEnterYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters`
  String get passwordAtLeast8Chars {
    return Intl.message(
      'Password must be at least 8 characters',
      name: 'passwordAtLeast8Chars',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get pleaseConfirmYourPassword {
    return Intl.message(
      'Please confirm your password',
      name: 'pleaseConfirmYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your old password`
  String get pleaseEnterYourOldPassword {
    return Intl.message(
      'Please enter your old password',
      name: 'pleaseEnterYourOldPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your new password`
  String get pleaseEnterYourNewPassword {
    return Intl.message(
      'Please enter your new password',
      name: 'pleaseEnterYourNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your new password`
  String get pleaseConfirmYourNewPassword {
    return Intl.message(
      'Please confirm your new password',
      name: 'pleaseConfirmYourNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Shared Designs`
  String get sharedDesigns {
    return Intl.message(
      'Shared Designs',
      name: 'sharedDesigns',
      desc: '',
      args: [],
    );
  }

  /// `Browse Categories`
  String get browseCategories {
    return Intl.message(
      'Browse Categories',
      name: 'browseCategories',
      desc: '',
      args: [],
    );
  }

  /// `Bohemian`
  String get bohemian {
    return Intl.message('Bohemian', name: 'bohemian', desc: '', args: []);
  }

  /// `No designs found`
  String get noDesignsFound {
    return Intl.message(
      'No designs found',
      name: 'noDesignsFound',
      desc: '',
      args: [],
    );
  }

  /// `No shared designs found`
  String get noSharedDesignsFound {
    return Intl.message(
      'No shared designs found',
      name: 'noSharedDesignsFound',
      desc: '',
      args: [],
    );
  }

  /// `No design details found`
  String get noDesignDetailsFound {
    return Intl.message(
      'No design details found',
      name: 'noDesignDetailsFound',
      desc: '',
      args: [],
    );
  }

  /// `Restyle this Design`
  String get restyleThisDesign {
    return Intl.message(
      'Restyle this Design',
      name: 'restyleThisDesign',
      desc: '',
      args: [],
    );
  }

  /// `Similar items`
  String get similarItems {
    return Intl.message(
      'Similar items',
      name: 'similarItems',
      desc: '',
      args: [],
    );
  }

  /// `We found similar items for your design.`
  String get foundSimilarItems {
    return Intl.message(
      'We found similar items for your design.',
      name: 'foundSimilarItems',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Share`
  String get cancelShare {
    return Intl.message(
      'Cancel Share',
      name: 'cancelShare',
      desc: '',
      args: [],
    );
  }

  /// `Prompt : `
  String get promptLabel {
    return Intl.message('Prompt : ', name: 'promptLabel', desc: '', args: []);
  }

  /// `Most recent`
  String get mostRecent {
    return Intl.message('Most recent', name: 'mostRecent', desc: '', args: []);
  }

  /// `Most liked`
  String get mostLiked {
    return Intl.message('Most liked', name: 'mostLiked', desc: '', args: []);
  }

  /// `No Designs`
  String get noDesigns {
    return Intl.message('No Designs', name: 'noDesigns', desc: '', args: []);
  }

  /// `No Shared Designs`
  String get noSharedDesigns {
    return Intl.message(
      'No Shared Designs',
      name: 'noSharedDesigns',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, =0 {No posts} =1 {1 post} other {{count} posts}}`
  String postsCountLabel(int count) {
    return Intl.plural(
      count,
      zero: 'No posts',
      one: '1 post',
      other: '$count posts',
      name: 'postsCountLabel',
      desc: '',
      args: [count],
    );
  }

  /// `Great for starters`
  String get planDesc1 {
    return Intl.message(
      'Great for starters',
      name: 'planDesc1',
      desc: '',
      args: [],
    );
  }

  /// `Most requested`
  String get planDesc2 {
    return Intl.message(
      'Most requested',
      name: 'planDesc2',
      desc: '',
      args: [],
    );
  }

  /// `Best choice for designers`
  String get planDesc3 {
    return Intl.message(
      'Best choice for designers',
      name: 'planDesc3',
      desc: '',
      args: [],
    );
  }

  /// `For intensive and professional use`
  String get planDesc4 {
    return Intl.message(
      'For intensive and professional use',
      name: 'planDesc4',
      desc: '',
      args: [],
    );
  }

  /// `Draw on the areas you want to remove or change.`
  String get drawMaskInstruction {
    return Intl.message(
      'Draw on the areas you want to remove or change.',
      name: 'drawMaskInstruction',
      desc: '',
      args: [],
    );
  }

  /// `Draw Mask`
  String get drawMaskTitle {
    return Intl.message('Draw Mask', name: 'drawMaskTitle', desc: '', args: []);
  }

  /// `Generate Mask`
  String get generateMaskBtn {
    return Intl.message(
      'Generate Mask',
      name: 'generateMaskBtn',
      desc: '',
      args: [],
    );
  }

  /// `Generate Design`
  String get generateDesignBtn {
    return Intl.message(
      'Generate Design',
      name: 'generateDesignBtn',
      desc: '',
      args: [],
    );
  }

  /// `Saving image to gallery...`
  String get savingImage {
    return Intl.message(
      'Saving image to gallery...',
      name: 'savingImage',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a description.`
  String get pleaseEnterDescription {
    return Intl.message(
      'Please enter a description.',
      name: 'pleaseEnterDescription',
      desc: '',
      args: [],
    );
  }

  /// `Please upload an image first`
  String get pleaseUploadImageFirst {
    return Intl.message(
      'Please upload an image first',
      name: 'pleaseUploadImageFirst',
      desc: '',
      args: [],
    );
  }

  /// `Design ID not available for this item.`
  String get designIdNotAvailable {
    return Intl.message(
      'Design ID not available for this item.',
      name: 'designIdNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Downloading image...`
  String get downloadingImage {
    return Intl.message(
      'Downloading image...',
      name: 'downloadingImage',
      desc: '',
      args: [],
    );
  }

  /// `Crop Image`
  String get cropImage {
    return Intl.message('Crop Image', name: 'cropImage', desc: '', args: []);
  }

  /// `Edit`
  String get editBtn {
    return Intl.message('Edit', name: 'editBtn', desc: '', args: []);
  }

  /// `Download`
  String get downloadBtn {
    return Intl.message('Download', name: 'downloadBtn', desc: '', args: []);
  }

  /// `Shared Design`
  String get sharedDesign {
    return Intl.message(
      'Shared Design',
      name: 'sharedDesign',
      desc: '',
      args: [],
    );
  }

  /// `Shared`
  String get shared {
    return Intl.message('Shared', name: 'shared', desc: '', args: []);
  }

  /// `Tokens`
  String get tokens {
    return Intl.message('Tokens', name: 'tokens', desc: '', args: []);
  }

  /// `Search designs...`
  String get searchDesigns {
    return Intl.message(
      'Search designs...',
      name: 'searchDesigns',
      desc: '',
      args: [],
    );
  }

  /// `Replacement Completed`
  String get replacementCompleted {
    return Intl.message(
      'Replacement Completed',
      name: 'replacementCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Edit Completed`
  String get editCompleted {
    return Intl.message(
      'Edit Completed',
      name: 'editCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Object Removed`
  String get objectRemoved {
    return Intl.message(
      'Object Removed',
      name: 'objectRemoved',
      desc: '',
      args: [],
    );
  }

  /// `Edit image`
  String get editImage {
    return Intl.message('Edit image', name: 'editImage', desc: '', args: []);
  }

  /// `Generate Design`
  String get historyTypeGenerateDesign {
    return Intl.message(
      'Generate Design',
      name: 'historyTypeGenerateDesign',
      desc: '',
      args: [],
    );
  }

  /// `Restyle Design`
  String get historyTypeRestyleDesign {
    return Intl.message(
      'Restyle Design',
      name: 'historyTypeRestyleDesign',
      desc: '',
      args: [],
    );
  }

  /// `Full Home`
  String get historyTypeFullHome {
    return Intl.message(
      'Full Home',
      name: 'historyTypeFullHome',
      desc: '',
      args: [],
    );
  }

  /// `Mask Edit`
  String get historyTypeMaskEdit {
    return Intl.message(
      'Mask Edit',
      name: 'historyTypeMaskEdit',
      desc: '',
      args: [],
    );
  }

  /// `Mask Replace`
  String get historyTypeMaskReplace {
    return Intl.message(
      'Mask Replace',
      name: 'historyTypeMaskReplace',
      desc: '',
      args: [],
    );
  }

  /// `Mask Remove`
  String get historyTypeMaskRemove {
    return Intl.message(
      'Mask Remove',
      name: 'historyTypeMaskRemove',
      desc: '',
      args: [],
    );
  }

  /// `Design`
  String get historyTypeDefault {
    return Intl.message(
      'Design',
      name: 'historyTypeDefault',
      desc: '',
      args: [],
    );
  }

  /// `Tokens are Not Enough`
  String get tokensAreNotEnough {
    return Intl.message(
      'Tokens are Not Enough',
      name: 'tokensAreNotEnough',
      desc: '',
      args: [],
    );
  }

  /// `.Upgrade to continue creating more designs.`
  String get upgradeToContinue {
    return Intl.message(
      '.Upgrade to continue creating more designs.',
      name: 'upgradeToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade`
  String get upgrade {
    return Intl.message('Upgrade', name: 'upgrade', desc: '', args: []);
  }

  /// `Get`
  String get getBtn {
    return Intl.message('Get', name: 'getBtn', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
