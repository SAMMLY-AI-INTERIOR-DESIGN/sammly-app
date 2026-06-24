import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/generated/l10n.dart';
import 'package:sammly/core/widgets/generate_action_buttons_row.dart';
import 'package:sammly/core/widgets/edit_download_action_buttons_row.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_state.dart';
import 'package:sammly/features/Explore/cubit/design_details_cubit.dart';
import 'package:sammly/features/Explore/cubit/design_details_states.dart';
import 'package:sammly/features/History/presentation/widgets/history_main_image_section.dart';
import 'package:sammly/features/smart_lens/cubit/search_cubit.dart';
import 'package:sammly/features/smart_lens/data/repo/search_repo.dart';
import 'package:sammly/features/smart_lens/presentation/widgets/smart_lens_bottom_sheet.dart';

import 'package:sammly/features/History/data/historymodel.dart';

class HistoryDetailsView extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String designId;
  final String? prompt;
  final String? generationType;
  final List<HistoryDesignModel>? groupedDesigns;

  const HistoryDetailsView({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.designId,
    this.prompt,
    this.generationType,
    this.groupedDesigns,
  });

  @override
  State<HistoryDetailsView> createState() => _HistoryDetailsViewState();
}

class _HistoryDetailsViewState extends State<HistoryDetailsView> {
  bool _isMaximized = false;
  bool _isShareLoading = false;
  late final SearchCubit _searchCubit;
  
  late String _selectedImage;
  late int _selectedIndex;
  String? _currentDesignId;
  List<HistoryDesignModel> _listImages = [];
  bool _showOriginal = false;

  @override
  void initState() {
    super.initState();
    _searchCubit = SearchCubit(SearchRepo());
    
    // Fetch details to update cubit state (like isShared, isFavorited)
    if (widget.designId.isNotEmpty) {
      context.read<DesignDetailsCubit>().fetchDesignDetails(widget.designId);
    }
    
    _currentDesignId = widget.designId;
    _selectedImage = widget.imageUrl;
    _selectedIndex = 0;
    
    if (widget.groupedDesigns != null && widget.groupedDesigns!.isNotEmpty) {
      _listImages = widget.groupedDesigns!;
      final index = _listImages.indexWhere((d) => d.imageUrl == widget.imageUrl);
      if (index != -1) {
        _selectedIndex = index;
      } else {
        _selectedImage = _listImages[0].imageUrl;
        _currentDesignId = _listImages[0].id;
      }
    }
  }

  @override
  void dispose() {
    _searchCubit.close();
    super.dispose();
  }

  void _openSmartLens(BuildContext context) {
    if (_currentDesignId == null || _currentDesignId!.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(S.of(context).designIdNotAvailable),
            backgroundColor: Colors.red,
          ),
        );
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isScrollControlled: true,
      builder: (context) {
        return BlocProvider.value(
          value: _searchCubit,
          child: SmartLensBottomSheet(designId: _currentDesignId!),
        );
      },
    );
  }

  void _toggleMaximize() {
    setState(() {
      _isMaximized = !_isMaximized;
    });
  }

  void _handleBack() {
    if (_isMaximized) {
      _toggleMaximize();
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> _shareNative() async {
    if (_selectedImage.isEmpty) return;

    try {
      setState(() {
        _isShareLoading = true;
      });

      final response = await http.get(Uri.parse(_selectedImage));
      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/shared_design.png');
        await file.writeAsBytes(response.bodyBytes);

        await Share.shareXFiles(
          [XFile(file.path)],
          text: 'Check out this amazing room design I generated with Sammly!',
        );
      } else {
        throw Exception('Failed to download image.');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Error sharing image: $e'),
              backgroundColor: Colors.red,
            ),
          );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isShareLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: !_isMaximized,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_isMaximized) _toggleMaximize();
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<FavoriteCubit, FavoriteState>(
            listener: (context, state) {
              if (state is FavoriteToggleSuccess) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: AppColors.primaryColor,
                    ),
                  );
              } else if (state is FavoriteToggleError) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
              }
            },
          ),
          BlocListener<DesignDetailsCubit, DesignDetailsState>(
            listener: (context, state) {
              if (state is DesignDetailsLoaded) {
                if (_currentDesignId != null) {
                  context.read<FavoriteCubit>().syncFavoriteStatus(
                    _currentDesignId!,
                    state.design.isFavorited,
                  );
                }
              } else if (state is DesignShareSuccess) {
                setState(() => _isShareLoading = false);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: AppColors.primaryColor,
                    ),
                  );
              } else if (state is DesignActionError) {
                setState(() => _isShareLoading = false);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
              } else if (state is DesignActionLoading) {
                setState(() => _isShareLoading = true);
              }
            },
          ),
        ],
        child: BlocBuilder<DesignDetailsCubit, DesignDetailsState>(
          builder: (context, designState) {
            final isMaskOrReplace = widget.generationType == 'mask_edit' ||
                widget.generationType == 'mask_replace' ||
                widget.generationType == 'mask_remove';
            
            final isShared = _currentDesignId != null 
                ? context.read<DesignDetailsCubit>().isSharedLocal(_currentDesignId!)
                : false;
            return Scaffold(
              backgroundColor: AppColors.whiteColor,
              appBar: _isMaximized
                  ? null
                  : CustomAppbar(
                      title: widget.title,
                      onBack: _handleBack,
                      actions: [
                        _isShareLoading
                            ? Padding(
                                padding: EdgeInsetsDirectional.only(
                                  end: 16.w,
                                ),
                                child: SizedBox(
                                  width: 20.w,
                                  height: 20.w,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : IconButton(
                                onPressed: _shareNative,
                                icon: SvgPicture.asset(
                                  AppImages.resultsShareIcon,
                                  width: 20.w,
                                  height: 20.h,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.blackColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                      ],
                    ),
              body: SafeArea(
                child: _isMaximized
                    ? _buildMaximizedView(screenHeight, screenWidth)
                    : _buildNormalView(isShared, isMaskOrReplace),
              ),
            );
          },
        ),
      ),
    );
  }

  /// الوضع العادي: صورة + تفاصيل + أزرار
  Widget _buildNormalView(bool isShared, bool isMaskOrReplace) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الصورة بالوضع العادي
          SizedBox(
            height: 320.h,
            width: double.infinity,
            child: BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, state) {
                final designState = context.read<DesignDetailsCubit>().state;
                final bool? isSaved = (designState is DesignDetailsLoading || designState is DesignDetailsInitial)
                    ? null
                    : (_currentDesignId != null 
                        ? context.read<FavoriteCubit>().isFavorite(_currentDesignId!)
                        : false);
                return HistoryMainImageSection(
                  imageUrl: _selectedImage,
                  isMaximized: false,
                  originalImagePath: _listImages.isNotEmpty ? _listImages[_selectedIndex].parentDesignUrl : null,
                  onToggleMaximize: _toggleMaximize,
                  onSmartLensTap: () => _openSmartLens(context),
                  isSaved: isSaved,
                  onSaveTap: () {
                    if (_currentDesignId != null) {
                      context.read<FavoriteCubit>().toggleFavorite(
                        _currentDesignId!,
                        isSaved ?? false,
                      );
                      context
                          .read<DesignDetailsCubit>()
                          .updateFavoriteStatus(!(isSaved ?? false));
                    }
                  },
                );
              },
            ),
          ),
          SizedBox(height: 16.h),
          if (_listImages.length > 1) ...[
            SizedBox(
              height: 100.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _listImages.length,
                separatorBuilder: (context, index) => SizedBox(width: 10.w),
                itemBuilder: (context, index) {
                  final design = _listImages[index];
                  final isSelected = _selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                        _selectedImage = design.imageUrl;
                        _currentDesignId = design.id;
                      });
                      context.read<DesignDetailsCubit>().fetchDesignDetails(design.id);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        gradient: isSelected ? AppColors.primaryGradient3 : null,
                        color: isSelected ? null : Colors.transparent,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          image: DecorationImage(
                            image: NetworkImage(design.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 17.h),
          ] else ...[
            SizedBox(height: 56.h),
          ],
          if (isMaskOrReplace)
            EditDownloadActionButtonsRow(
              imageUrl: _selectedImage,
              onEdit: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.imageGenerationStepperView,
                  arguments: {
                    'initialImageUrl': _selectedImage,
                    'isEditMode': true,
                  },
                );
              },
            )
          else
            GenerateActionButtonsRow(
              imageUrl: _selectedImage,
              isShared: isShared,
              onEdit: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.imageGenerationStepperView,
                  arguments: {
                    'initialImageUrl': _selectedImage,
                    'isEditMode': true,
                  },
                );
              },
              onShare: () {
                if (_currentDesignId != null) {
                  context.read<DesignDetailsCubit>().shareDesign(_currentDesignId!);
                }
              },
            ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  /// وضع التكبير
  Widget _buildMaximizedView(double screenHeight, double screenWidth) {
    final originalImagePath = _listImages.isNotEmpty ? _listImages[_selectedIndex].parentDesignUrl : null;
    final displayUrl = _showOriginal && originalImagePath != null && originalImagePath.isNotEmpty
        ? originalImagePath
        : _selectedImage;

    return Stack(
      children: [
        Positioned.fill(
          child: displayUrl.isEmpty
              ? Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(Icons.broken_image, color: Colors.grey),
                  ),
                )
              : Image.network(
                  displayUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.broken_image, color: Colors.grey),
                      ),
                    );
                  },
                ),
        ),
        PositionedDirectional(
          top: 12.h,
          start: 12.w,
          child: GestureDetector(
            onTap: _toggleMaximize,
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.whiteColor.withValues(alpha: 0.85),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.blackColor,
                size: 20.sp,
              ),
            ),
          ),
        ),
        PositionedDirectional(
          bottom: 24.h,
          end: 24.w,
          child: GestureDetector(
            onTap: _toggleMaximize,
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.bg2Color, AppColors.bg1Color],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: SvgPicture.asset(AppImages.minimizeimage, width: 20.w),
            ),
          ),
        ),
        
        // Switch image button
        if (originalImagePath != null && originalImagePath.isNotEmpty)
          PositionedDirectional(
            bottom: 24.h,
            end: 64.w,
            child: GestureDetector(
              onTapDown: (_) => setState(() => _showOriginal = true),
              onTapUp: (_) => setState(() => _showOriginal = false),
              onTapCancel: () => setState(() => _showOriginal = false),
              child: SvgPicture.asset(
                AppImages.switchImageIcon,
                width: 28.w,
                height: 28.h,
              ),
            ),
          ),
      ],
    );
  }
}
