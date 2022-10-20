part of '../cars_screen.dart';

class _CarItem extends StatelessWidget {
  const _CarItem({Key? key, required this.model}) : super(key: key);

  final CarModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (model.url != null && model.url!.isNotEmpty)
          CachedNetworkImage(
            imageUrl: model.url!,
            imageBuilder: (context, imageProvider) => Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => const SizedBox(
              height: 200,
              width: double.infinity,
              child: Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => const SizedBox(
              height: 200,
              width: double.infinity,
              child: Center(child: Icon(Icons.error)),
            ),
          ),
        if (model.localImage != null)
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              image: DecorationImage(
                image: FileImage(model.localImage!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${model.marka}  ${model.model}',
              style: AppTextStyle.w50018,
            ),
            Text(
              '${model.year} год',
              style: AppTextStyle.w50018blueAccent,
            ),
          ],
        ),
        const SizedBox(height: 1.8),
        Text(
          '${model.price} \$',
          style: AppTextStyle.w70016blueAccent,
        )
      ],
    );
  }
}
