import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/utils/cache.dart';

class ImagePreview extends StatefulWidget {
  final String photo;
  const ImagePreview({super.key, required this.photo});

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  var db = CacheService.getDb();
  @override
  void initState() {
    db = CacheService.getDb();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: 'https://naqshsoft.site/images/$db/${widget.photo}',
            fit: BoxFit.contain,
            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>  Icon(Icons.image_not_supported_outlined,size: 64.h,),
          ),
        ),
      ),
    );
  }
}
