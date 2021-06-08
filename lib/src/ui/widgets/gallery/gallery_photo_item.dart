import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vootech_realchat/src/ui/widgets/busy_indicator.dart';

class GalleryPhotoItem {
  final String id;
  final String resource;

  GalleryPhotoItem({this.id, this.resource});
}

class GalleryPhotoItemThumbnail extends StatelessWidget {
  const GalleryPhotoItemThumbnail({
    Key key,
    this.galleryItem,
    this.onTap,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final GalleryPhotoItem galleryItem;

  final GestureTapCallback onTap;

  final AnimationController animationController;

  final Animation animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(0.0, 50 * (1.0 - animation.value), 0.0),
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.all(8),
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  decoration: BoxDecoration(color: Colors.white70),
                  child: Hero(
                    tag: galleryItem.id,
                    child: CachedNetworkImage(
                      imageUrl: "/${galleryItem.resource}",
                      placeholder: (context, url) => new SizedBox(height: 80, width: 80, child: BusyIndicator(size: 28)),
                      errorWidget: (context, url, error) => new SizedBox(height: 80, width: 80, child: Image.asset('assets/images/as.png')),
                      imageBuilder: (context, imageProvider) => Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                          boxShadow: [
                            BoxShadow(color: Colors.grey.withOpacity(0.5), offset: new Offset(0.0, 0.0), blurRadius: 2.0, spreadRadius: 0.0),
                          ],
                          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
