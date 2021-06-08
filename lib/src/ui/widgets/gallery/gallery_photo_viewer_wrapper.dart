import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:vootech_realchat/src/ui/widgets/dots_indicator.dart';

import 'gallery_photo_item.dart';

class GalleryPhotoViewWrapper extends StatefulWidget {
  final Widget loadingChild;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<GalleryPhotoItem> galleryItems;
  final bool usePageViewWrapper;

  GalleryPhotoViewWrapper({
    this.loadingChild,
    this.usePageViewWrapper = false,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex,
    @required this.galleryItems,
  }) : pageController = PageController(initialPage: initialIndex);

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  int currentIndex;

  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  @override
  void dispose() {
    widget.pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int index) {
    if (widget.usePageViewWrapper) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cancelBtn = Container(
      height: 35.0,
      width: 35.0,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).accentColor.withOpacity(0.2)),
      child: IconButton(
        icon: Icon(Icons.close, color: Theme.of(context).accentColor),
        onPressed: () => Navigator.pop(context),
        iconSize: 20.0,
      ),
    );
    final cancelBtnLTR = Positioned(top: 30.0, left: 10.0, child: cancelBtn);
    return Scaffold(
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(height: MediaQuery.of(context).size.height),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Positioned.fill(
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: _buildItem,
                itemCount: widget.galleryItems.length,
                loadingBuilder: (context, event) => Center(
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      value: event == null ? 0 : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                    ),
                  ),
                ),
                backgroundDecoration: widget.backgroundDecoration,
                pageController: widget.pageController,
                onPageChanged: onPageChanged,
              ),
            ),
            widget.usePageViewWrapper
                ? Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Image ${currentIndex + 1}",
                      style: const TextStyle(color: Colors.white, fontSize: 17.0, decoration: null),
                    ),
                  )
                : Container(),
            cancelBtnLTR,
            new Positioned(
              bottom: 10.0,
              left: 0.0,
              right: 0.0,
              child: new SafeArea(
                child: new Column(
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new DotsIndicator(
                        color: Theme.of(context).accentColor,
                        controller: widget.pageController,
                        itemCount: widget.galleryItems.length,
                        onPageSelected: (int page) {
                          widget.pageController.animateToPage(
                            page,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final GalleryPhotoItem item = widget.galleryItems[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(item.resource),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 1.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item.id),
    );
  }
}
