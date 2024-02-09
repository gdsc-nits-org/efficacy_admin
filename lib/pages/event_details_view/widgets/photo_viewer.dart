import 'package:cached_network_image/cached_network_image.dart';
import 'package:efficacy_admin/config/configurations/assets/assets.dart';
import 'package:efficacy_admin/models/event/event_model.dart';
import 'package:efficacy_admin/utils/local_database/local_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:photo_view/photo_view.dart';

class EventPosterViewer extends StatefulWidget {
  EventModel currentEvent;
  EventPosterViewer({super.key, required this.currentEvent});

  @override
  State<EventPosterViewer> createState() => _EventPosterViewerState();
}

class _EventPosterViewerState extends State<EventPosterViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          (widget.currentEvent.posterURL.isNotEmpty)
              ? PhotoView(
                  imageProvider: CachedNetworkImageProvider(
                  widget.currentEvent.posterURL,
                  errorListener: (BuildContext) {
                    Image.asset(Assets.mediaImgPath);
                  },
                  cacheManager: CacheManager(
                    Config(
                      widget.currentEvent.posterURL,
                      stalePeriod: LocalDatabase.stalePeriod,
                    ),
                  ),
                ))
              : PhotoView(imageProvider: const AssetImage(Assets.mediaImgPath)),
              Positioned(
                left: 20,
                top: 30,
                child: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),))
        ],
      ),
    );
  }
}
