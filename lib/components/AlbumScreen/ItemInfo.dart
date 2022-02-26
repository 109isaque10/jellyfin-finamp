import 'package:flutter/material.dart';

import '../../models/JellyfinModels.dart';
import '../../services/processArtist.dart';
import '../../services/processProductionYear.dart';
import '../printDuration.dart';

class ItemInfo extends StatelessWidget {
  const ItemInfo({
    Key? key,
    required this.item,
    required this.itemSongs,
  }) : super(key: key);

  final BaseItemDto item;
  final int itemSongs;

// TODO: see if there's a way to expand this column to the row that it's in
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (item.type != "Playlist")
          _IconAndText(
              iconData: Icons.person, text: processArtist(item.albumArtist)),
        _IconAndText(
            iconData: Icons.music_note, text: "${itemSongs.toString()} Songs"),
        _IconAndText(
            iconData: Icons.timer,
            text: printDuration(Duration(
                microseconds:
                    item.runTimeTicks == null ? 0 : item.runTimeTicks! ~/ 10))),
        if (item.type != "Playlist")
          _IconAndText(
              iconData: Icons.event,
              text: processProductionYear(item.productionYear))
      ],
    );
  }
}

class _IconAndText extends StatelessWidget {
  const _IconAndText({
    Key? key,
    required this.iconData,
    required this.text,
  }) : super(key: key);

  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            // Inactive icons have an opacity of 50%
            // https://material.io/design/iconography/system-icons.html#color
            color: Colors.white.withOpacity(0.5),
          ),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
