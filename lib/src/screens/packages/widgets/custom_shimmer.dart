part of select_package;

// ignore: camel_case_types
class _customShimmer extends StatelessWidget {
  const _customShimmer();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ShimmerBoxWidget(w: context.mWidth / 3, h: 20),
            20.ph,
            ShimmerBoxWidget(w: context.mWidth, h: 40),
            20.ph,
            ShimmerBoxWidget(w: context.mWidth / 3, h: 20),
            20.ph,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List<Widget>.generate(
                  4,
                  (int index) => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: AppColors.customGrey, width: 2)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                const ShimmerBoxWidget(
                                    w: 50, h: 50, shape: BoxShape.circle),
                                10.pw,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ShimmerBoxWidget(w: context.mWidth / 5),
                                    10.ph,
                                    ShimmerBoxWidget(w: context.mWidth / 4),
                                  ],
                                ),
                              ],
                            ),
                            const ShimmerBoxWidget(
                                w: 20, h: 20, shape: BoxShape.circle),
                          ],
                        ),
                      )),
            ),
            const Spacer(),
            ShimmerBoxWidget(w: context.mWidth, h: 60),
          ],
        ),
      ),
    );
  }
}
